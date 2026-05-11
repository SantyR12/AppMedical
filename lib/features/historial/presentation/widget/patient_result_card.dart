import 'package:flutter/material.dart';

import '../../domain/models/patient_model.dart';

/// Widget reutilizable para mostrar un resultado de búsqueda de paciente.
/// PB-14 criterio 3: muestra nombre completo, tipo y número de documento,
/// edad calculada y último médico tratante.
///
/// Usado en PatientSearchScreen y en cualquier lista de pacientes futura.
class PatientResultCard extends StatelessWidget {
  const PatientResultCard({
    super.key,
    required this.patient,
    this.onTap,
    this.showLastDoctor = true,
  });

  final PatientModel patient;
  final VoidCallback? onTap;
  final bool showLastDoctor;

  int get _edad {
    final hoy = DateTime.now();
    int edad = hoy.year - patient.fechaNacimiento.year;
    if (hoy.month < patient.fechaNacimiento.month ||
        (hoy.month == patient.fechaNacimiento.month &&
            hoy.day < patient.fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Avatar con inicial
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  patient.nombreCompleto.isNotEmpty
                      ? patient.nombreCompleto[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Datos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre
                    Text(
                      patient.nombreCompleto,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Documento y edad
                    Text(
                      '${patient.tipoDocumento.name.toUpperCase()} '
                      '${patient.numeroDocumento}  ·  $_edad años',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),

                    // Último médico tratante
                    if (showLastDoctor &&
                        patient.ultimoMedicoTratante != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Médico: ${patient.ultimoMedicoTratante}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
