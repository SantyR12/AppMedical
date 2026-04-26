import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergy_model.freezed.dart';
part 'allergy_model.g.dart';

/// Tipos de reacción alérgica (PB-20 criterio 1)
enum ReactionType {
  @JsonValue('anafilaxia') anafilaxia,
  @JsonValue('urticaria') urticaria,
  @JsonValue('angioedema') angioedema,
  @JsonValue('intolerancia') intolerancia,
  @JsonValue('otra') otra,
}

/// Severidad de la alergia (PB-20 criterio 1)
enum AllergySeverity {
  @JsonValue('leve') leve,
  @JsonValue('moderada') moderada,
  @JsonValue('grave') grave,
  @JsonValue('mortal') mortal,
}

/// Estado de la alergia (PB-20 criterio 3)
/// Solo un médico puede cambiarla de activa a inactiva
enum AllergyStatus {
  @JsonValue('activa') activa,
  @JsonValue('inactiva') inactiva,
}

/// Modelo de alergia del paciente (PB-20)
///
/// Generar archivos con:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
abstract class AllergyModel with _$AllergyModel {
  const AllergyModel._();
  const factory AllergyModel({
    required String id,
    required String pacienteId,
    // El agente usa la misma base de datos de medicamentos (PB-20 criterio 4)
    required String agenteCausante,
    required ReactionType tipoReaccion,
    required AllergySeverity severidad,
    @Default(AllergyStatus.activa) AllergyStatus estado,
    DateTime? fechaDiagnostico,
    String? observaciones,
    DateTime? creadoEn,
    String? creadoPor,
  }) = _AllergyModel;

  factory AllergyModel.fromJson(Map<String, dynamic> json) =>
      _$AllergyModelFromJson(json);
}

/// Payload para registrar una nueva alergia (PB-20)
@freezed
abstract class CreateAllergyRequest with _$CreateAllergyRequest {
  const CreateAllergyRequest._();
  const factory CreateAllergyRequest({
    required String pacienteId,
    required String agenteCausante,
    required ReactionType tipoReaccion,
    required AllergySeverity severidad,
    DateTime? fechaDiagnostico,
    String? observaciones,
  }) = _CreateAllergyRequest;

  factory CreateAllergyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAllergyRequestFromJson(json);
}

/// Modelo de medicamento — usado en el autocompletado de alergias y
/// en prescripciones (PB-15, PB-20 criterio 4, misma base de datos)
@freezed
abstract class MedicationModel with _$MedicationModel {
  const MedicationModel._();
  const factory MedicationModel({
    required String id,
    required String nombreGenerico,
    String? nombreComercial,
    String? categoria,
  }) = _MedicationModel;

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      _$MedicationModelFromJson(json);
}

