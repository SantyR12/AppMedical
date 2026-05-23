-- ============================================================
-- SAMUEL GUERRERO — Daily 3 (13/05) — PB-23 · PB-24 · PB-25
-- Diagnósticos CIE-10, clasificación de tipo y estado
-- ============================================================

DO $$ BEGIN
  CREATE TYPE tipo_diagnostico AS ENUM ('principal','secundario','presuntivo','definitivo');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE estado_diagnostico AS ENUM ('activo','resuelto','cronico');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE TABLE IF NOT EXISTS diagnosticos (
  id                  UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  historia_clinica_id UUID              NOT NULL REFERENCES historias_clinicas(id) ON DELETE CASCADE,
  paciente_id         UUID              NOT NULL REFERENCES pacientes(id),
  codigo_cie10        VARCHAR(10)       NOT NULL,
  descripcion         TEXT              NOT NULL,
  tipo                tipo_diagnostico  NOT NULL DEFAULT 'presuntivo',
  estado              estado_diagnostico NOT NULL DEFAULT 'activo',
  registrado_por      UUID              NOT NULL REFERENCES usuarios(id),
  creado_en           TIMESTAMPTZ       NOT NULL DEFAULT now(),
  actualizado_en      TIMESTAMPTZ       NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_diagnosticos_historia ON diagnosticos (historia_clinica_id);
CREATE INDEX IF NOT EXISTS idx_diagnosticos_paciente ON diagnosticos (paciente_id);
CREATE INDEX IF NOT EXISTS idx_diagnosticos_cie10    ON diagnosticos (codigo_cie10);
CREATE INDEX IF NOT EXISTS idx_diagnosticos_estado   ON diagnosticos (estado);

CREATE OR REPLACE FUNCTION set_actualizado_en()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.actualizado_en = now(); RETURN NEW; END $$;

CREATE TRIGGER trg_diagnosticos_actualizado_en
  BEFORE UPDATE ON diagnosticos
  FOR EACH ROW EXECUTE FUNCTION set_actualizado_en();

-- PB-26: Vista de lista de problemas activos
CREATE OR REPLACE VIEW lista_problemas AS
  SELECT d.id, d.paciente_id, d.historia_clinica_id,
         d.codigo_cie10, d.descripcion, d.tipo, d.estado,
         d.registrado_por, d.creado_en
  FROM diagnosticos d
  WHERE d.estado IN ('activo','cronico')
  ORDER BY d.creado_en DESC;

-- Catálogo CIE-10 mínimo
CREATE TABLE IF NOT EXISTS catalogo_cie10 (
  codigo      VARCHAR(10) PRIMARY KEY,
  descripcion TEXT        NOT NULL,
  capitulo    VARCHAR(5),
  categoria   VARCHAR(150)
);

INSERT INTO catalogo_cie10 (codigo, descripcion, capitulo, categoria) VALUES
  ('E11',   'Diabetes mellitus tipo 2',                      'IV',   'Enfermedades endocrinas'),
  ('E11.9', 'Diabetes mellitus tipo 2 sin complicaciones',   'IV',   'Enfermedades endocrinas'),
  ('E78.0', 'Hipercolesterolemia pura',                      'IV',   'Enfermedades endocrinas'),
  ('I10',   'Hipertensión esencial (primaria)',               'IX',   'Enfermedades cardiovasculares'),
  ('I21.9', 'Infarto agudo de miocardio no especificado',    'IX',   'Enfermedades cardiovasculares'),
  ('I50.0', 'Insuficiencia cardíaca congestiva',             'IX',   'Enfermedades cardiovasculares'),
  ('J00',   'Rinofaringitis aguda (resfriado común)',         'X',    'Enfermedades respiratorias'),
  ('J06.9', 'Infección aguda vías respiratorias superiores', 'X',    'Enfermedades respiratorias'),
  ('J18.9', 'Neumonía no especificada',                       'X',    'Enfermedades respiratorias'),
  ('J45.0', 'Asma predominantemente alérgica',               'X',    'Enfermedades respiratorias'),
  ('J45.9', 'Asma no especificada',                           'X',    'Enfermedades respiratorias'),
  ('K21.0', 'Reflujo gastroesofágico con esofagitis',        'XI',   'Enfermedades digestivas'),
  ('K29.7', 'Gastritis no especificada',                      'XI',   'Enfermedades digestivas'),
  ('M54.5', 'Lumbago no especificado',                        'XIII', 'Músculo-esqueléticas'),
  ('N39.0', 'Infección de las vías urinarias',               'XIV',  'Genitourinarias'),
  ('R05',   'Tos',                                             'XVIII','Síntomas generales'),
  ('R50.9', 'Fiebre no especificada',                         'XVIII','Síntomas generales'),
  ('R51',   'Cefalea',                                         'XVIII','Síntomas generales'),
  ('Z00.0', 'Examen médico general',                          'XXI',  'Factores de salud'),
  ('Z30',   'Anticoncepción',                                  'XXI',  'Factores de salud')
ON CONFLICT (codigo) DO NOTHING;
