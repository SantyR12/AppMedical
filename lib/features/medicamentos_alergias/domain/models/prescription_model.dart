import 'package:freezed_annotation/freezed_annotation.dart';

part 'prescription_model.freezed.dart';
part 'prescription_model.g.dart';

/// Vías de administración (PB-15 criterio 1)
enum AdministrationRoute {
  @JsonValue('oral') oral,
  @JsonValue('IV') iv,
  @JsonValue('IM') im,
  @JsonValue('subcutanea') subcutanea,
  @JsonValue('topica') topica,
}

/// Unidades de dosis (PB-15 criterio 1)
enum DoseUnit {
  @JsonValue('mg') mg,
  @JsonValue('ml') ml,
  @JsonValue('mcg') mcg,
  @JsonValue('unidades') unidades,
}

/// Estado de la prescripción
enum PrescriptionStatus {
  @JsonValue('activa') activa,
  @JsonValue('completada') completada,
  @JsonValue('cancelada') cancelada,
}

/// Modelo de prescripción digital (PB-15)
///
/// Generar archivos con:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
class PrescriptionModel with _$PrescriptionModel {
  const factory PrescriptionModel({
    required String id,
    required String pacienteId,
    required String medicoId,
    required String medicoNombre,
    required String medicamentoId,
    required String medicamentoNombre,
    required double dosis,
    required DoseUnit dosisUnidad,
    // Frecuencia en horas (ej: cada 8 horas = 8)
    required int frecuenciaHoras,
    required AdministrationRoute viaAdministracion,
    required int duracionDias,
    String? indicacionesEspeciales,
    @Default(PrescriptionStatus.activa) PrescriptionStatus estado,
    DateTime? fechaPrescripcion,
    // Firma digital (PB-15 criterio 5)
    String? firmaDigital,
    String? matriculaMedico,
  }) = _PrescriptionModel;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);
}

/// Request para crear una prescripción
@freezed
class CreatePrescriptionRequest with _$CreatePrescriptionRequest {
  const factory CreatePrescriptionRequest({
    required String pacienteId,
    required String medicamentoId,
    required String medicamentoNombre,
    required double dosis,
    required DoseUnit dosisUnidad,
    required int frecuenciaHoras,
    required AdministrationRoute viaAdministracion,
    required int duracionDias,
    String? indicacionesEspeciales,
  }) = _CreatePrescriptionRequest;

  factory CreatePrescriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePrescriptionRequestFromJson(json);
}

/// Alerta de duplicidad — PB-15 criterio 2
@freezed
class DuplicityAlert with _$DuplicityAlert {
  const factory DuplicityAlert({
    required bool hasDuplicity,
    String? existingPrescriptionId,
    String? medicamentoNombre,
  }) = _DuplicityAlert;

  factory DuplicityAlert.fromJson(Map<String, dynamic> json) =>
      _$DuplicityAlertFromJson(json);
}

/// Alerta de alergia — PB-15 criterio 3
@freezed
class AllergyAlert with _$AllergyAlert {
  const factory AllergyAlert({
    required bool hasAllergy,
    String? allergyId,
    String? agenteCausante,
    String? severidad,
  }) = _AllergyAlert;

  factory AllergyAlert.fromJson(Map<String, dynamic> json) =>
      _$AllergyAlertFromJson(json);
}
