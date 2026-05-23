import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_model.freezed.dart';
part 'diagnosis_model.g.dart';

enum TipoDiagnostico {
  @JsonValue('principal')  principal,
  @JsonValue('secundario') secundario,
  @JsonValue('presuntivo') presuntivo,
  @JsonValue('definitivo') definitivo,
}

enum EstadoDiagnostico {
  @JsonValue('activo')   activo,
  @JsonValue('resuelto') resuelto,
  @JsonValue('cronico')  cronico,
}

@freezed
abstract class DiagnosisModel with _$DiagnosisModel {
  const factory DiagnosisModel({
    required String id,
    required String historiaClinicaId,
    required String pacienteId,
    required String codigoCie10,
    required String descripcion,
    @Default(TipoDiagnostico.presuntivo)  TipoDiagnostico tipo,
    @Default(EstadoDiagnostico.activo)    EstadoDiagnostico estado,
    String? registradoPor,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) = _DiagnosisModel;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisModelFromJson(json);
}

@freezed
abstract class CreateDiagnosisRequest with _$CreateDiagnosisRequest {
  const factory CreateDiagnosisRequest({
    required String historiaClinicaId,
    required String pacienteId,
    required String codigoCie10,
    required String descripcion,
    required TipoDiagnostico tipo,
    @Default(EstadoDiagnostico.activo) EstadoDiagnostico estado,
  }) = _CreateDiagnosisRequest;

  factory CreateDiagnosisRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDiagnosisRequestFromJson(json);
}

@freezed
abstract class Cie10Item with _$Cie10Item {
  const factory Cie10Item({
    required String codigo,
    required String descripcion,
  }) = _Cie10Item;

  factory Cie10Item.fromJson(Map<String, dynamic> json) =>
      _$Cie10ItemFromJson(json);
}
