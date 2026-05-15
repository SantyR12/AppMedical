import 'package:freezed_annotation/freezed_annotation.dart';

part 'mar_model.freezed.dart';
part 'mar_model.g.dart';

enum ResultadoAdministracion {
  @JsonValue('administrado')       administrado,
  @JsonValue('omitido')            omitido,
  @JsonValue('rechazado_paciente') rechazadoPaciente,
  @JsonValue('contraindicado')     contraindicado,
}

@freezed
abstract class MarEntryModel with _$MarEntryModel {
  const factory MarEntryModel({
    required String id,
    required String prescripcionId,
    required String pacienteId,
    required DateTime horaProgramada,
    DateTime? horaReal,
    String? administradoPor,
    @Default(ResultadoAdministracion.administrado) ResultadoAdministracion resultado,
    String? dosisAdministrada,
    String? viaAdministrada,
    String? observaciones,
    DateTime? creadoEn,
    String? nombreMedicamento,
    String? dosisPrescrita,
  }) = _MarEntryModel;

  factory MarEntryModel.fromJson(Map<String, dynamic> json) =>
      _$MarEntryModelFromJson(json);
}

@freezed
abstract class RegisterMarEntryRequest with _$RegisterMarEntryRequest {
  const factory RegisterMarEntryRequest({
    required String prescripcionId,
    required DateTime horaReal,
    required ResultadoAdministracion resultado,
    String? dosisAdministrada,
    String? viaAdministrada,
    String? observaciones,
  }) = _RegisterMarEntryRequest;

  factory RegisterMarEntryRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterMarEntryRequestFromJson(json);
}
