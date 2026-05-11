import 'package:freezed_annotation/freezed_annotation.dart';

part 'soap_note_model.freezed.dart';
part 'soap_note_model.g.dart';

/// PB-11: Nota de evolución en formato SOAP.
///
/// SOAP = Subjetivo (síntomas del paciente) · Objetivo (hallazgos clínicos)
///        Análisis (diagnóstico) · Plan (tratamiento y seguimiento)
///
/// Generar archivos con:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
abstract class SoapNoteModel with _$SoapNoteModel {
  const factory SoapNoteModel({
    required String id,
    required String historiaClinicaId,
    required String pacienteId,
    /// S: síntomas y motivo de consulta reportados por el paciente
    required String subjetivo,
    /// O: hallazgos del examen físico, signos vitales, laboratorios
    required String objetivo,
    /// A: interpretación clínica y diagnóstico
    required String analisis,
    /// P: tratamiento, medicamentos, seguimiento, interconsultas
    required String plan,
    String? creadoPor,
    DateTime? creadoEn,
  }) = _SoapNoteModel;

  factory SoapNoteModel.fromJson(Map<String, dynamic> json) =>
      _$SoapNoteModelFromJson(json);
}

/// Payload para crear una nueva nota SOAP (PB-11)
@freezed
abstract class CreateSoapNoteRequest with _$CreateSoapNoteRequest {
  const factory CreateSoapNoteRequest({
    required String historiaClinicaId,
    required String pacienteId,
    required String subjetivo,
    required String objetivo,
    required String analisis,
    required String plan,
  }) = _CreateSoapNoteRequest;

  factory CreateSoapNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSoapNoteRequestFromJson(json);
}
