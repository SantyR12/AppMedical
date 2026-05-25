enum DiagnosisTipo { principal, secundario, presuntivo, definitivo }
enum DiagnosisEstado { activo, resuelto, cronico }

class Cie10Item {
  const Cie10Item({required this.codigo, required this.descripcion});
  final String codigo;
  final String descripcion;

  factory Cie10Item.fromJson(Map<String, dynamic> json) => Cie10Item(
        codigo: json['codigo'] as String,
        descripcion: json['descripcion'] as String,
      );

  @override
  String toString() => '$codigo — $descripcion';
}

class DiagnosisModel {
  const DiagnosisModel({
    required this.id,
    required this.pacienteId,
    required this.historiaClinicaId,
    required this.codigoCie10,
    required this.descripcion,
    required this.tipo,
    required this.estado,
    this.registradoPor,
    this.creadoEn,
  });

  final String id;
  final String pacienteId;
  final String historiaClinicaId;
  final String codigoCie10;
  final String descripcion;
  final DiagnosisTipo tipo;
  final DiagnosisEstado estado;
  final String? registradoPor;
  final DateTime? creadoEn;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        id: json['id'] as String,
        pacienteId: json['pacienteId'] as String,
        historiaClinicaId: json['historiaClinicaId'] as String,
        codigoCie10: json['codigoCie10'] as String,
        descripcion: json['descripcion'] as String,
        tipo: _tipoFromString(json['tipo'] as String),
        estado: _estadoFromString(json['estado'] as String),
        registradoPor: json['registradoPor'] as String?,
        creadoEn: json['creadoEn'] != null
            ? DateTime.tryParse(json['creadoEn'] as String)
            : null,
      );

  static DiagnosisTipo _tipoFromString(String s) {
    switch (s) {
      case 'secundario':  return DiagnosisTipo.secundario;
      case 'presuntivo':  return DiagnosisTipo.presuntivo;
      case 'definitivo':  return DiagnosisTipo.definitivo;
      default:            return DiagnosisTipo.principal;
    }
  }

  static DiagnosisEstado _estadoFromString(String s) {
    switch (s) {
      case 'resuelto': return DiagnosisEstado.resuelto;
      case 'cronico':  return DiagnosisEstado.cronico;
      default:         return DiagnosisEstado.activo;
    }
  }
}
