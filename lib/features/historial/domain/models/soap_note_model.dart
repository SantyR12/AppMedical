class SoapNoteModel {
  const SoapNoteModel({
    required this.id,
    required this.pacienteId,
    required this.historiaClinicaId,
    required this.subjetivo,
    required this.objetivo,
    required this.analisis,
    required this.plan,
    this.creadoPor,
    this.creadoEn,
  });

  final String id;
  final String pacienteId;
  final String historiaClinicaId;
  final String subjetivo;
  final String objetivo;
  final String analisis;
  final String plan;
  final String? creadoPor;
  final DateTime? creadoEn;

  factory SoapNoteModel.fromJson(Map<String, dynamic> json) => SoapNoteModel(
        id: json['id'] as String,
        pacienteId: json['pacienteId'] as String,
        historiaClinicaId: json['historiaClinicaId'] as String,
        subjetivo: json['subjetivo'] as String,
        objetivo: json['objetivo'] as String,
        analisis: json['analisis'] as String,
        plan: json['plan'] as String,
        creadoPor: json['creadoPor'] as String?,
        creadoEn: json['creadoEn'] != null
            ? DateTime.tryParse(json['creadoEn'] as String)
            : null,
      );
}

/// Payload para crear una nota SOAP
class CreateSoapNoteRequest {
  const CreateSoapNoteRequest({
    required this.historiaClinicaId,
    required this.pacienteId,
    required this.subjetivo,
    required this.objetivo,
    required this.analisis,
    required this.plan,
  });

  final String historiaClinicaId;
  final String pacienteId;
  final String subjetivo;
  final String objetivo;
  final String analisis;
  final String plan;

  Map<String, dynamic> toJson() => {
        'historiaClinicaId': historiaClinicaId,
        'pacienteId': pacienteId,
        'subjetivo': subjetivo,
        'objetivo': objetivo,
        'analisis': analisis,
        'plan': plan,
      };
}
