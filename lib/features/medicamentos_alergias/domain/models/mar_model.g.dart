// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarEntryModel _$MarEntryModelFromJson(Map<String, dynamic> json) =>
    _MarEntryModel(
      id: json['id'] as String,
      prescripcionId: json['prescripcionId'] as String,
      pacienteId: json['pacienteId'] as String,
      horaProgramada: DateTime.parse(json['horaProgramada'] as String),
      horaReal: json['horaReal'] == null
          ? null
          : DateTime.parse(json['horaReal'] as String),
      administradoPor: json['administradoPor'] as String?,
      resultado:
          $enumDecodeNullable(
            _$ResultadoAdministracionEnumMap,
            json['resultado'],
          ) ??
          ResultadoAdministracion.administrado,
      dosisAdministrada: json['dosisAdministrada'] as String?,
      viaAdministrada: json['viaAdministrada'] as String?,
      observaciones: json['observaciones'] as String?,
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
      nombreMedicamento: json['nombreMedicamento'] as String?,
      dosisPrescrita: json['dosisPrescrita'] as String?,
    );

Map<String, dynamic> _$MarEntryModelToJson(_MarEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prescripcionId': instance.prescripcionId,
      'pacienteId': instance.pacienteId,
      'horaProgramada': instance.horaProgramada.toIso8601String(),
      'horaReal': instance.horaReal?.toIso8601String(),
      'administradoPor': instance.administradoPor,
      'resultado': _$ResultadoAdministracionEnumMap[instance.resultado]!,
      'dosisAdministrada': instance.dosisAdministrada,
      'viaAdministrada': instance.viaAdministrada,
      'observaciones': instance.observaciones,
      'creadoEn': instance.creadoEn?.toIso8601String(),
      'nombreMedicamento': instance.nombreMedicamento,
      'dosisPrescrita': instance.dosisPrescrita,
    };

const _$ResultadoAdministracionEnumMap = {
  ResultadoAdministracion.administrado: 'administrado',
  ResultadoAdministracion.omitido: 'omitido',
  ResultadoAdministracion.rechazadoPaciente: 'rechazado_paciente',
  ResultadoAdministracion.contraindicado: 'contraindicado',
};

_RegisterMarEntryRequest _$RegisterMarEntryRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterMarEntryRequest(
  prescripcionId: json['prescripcionId'] as String,
  horaReal: DateTime.parse(json['horaReal'] as String),
  resultado: $enumDecode(_$ResultadoAdministracionEnumMap, json['resultado']),
  dosisAdministrada: json['dosisAdministrada'] as String?,
  viaAdministrada: json['viaAdministrada'] as String?,
  observaciones: json['observaciones'] as String?,
);

Map<String, dynamic> _$RegisterMarEntryRequestToJson(
  _RegisterMarEntryRequest instance,
) => <String, dynamic>{
  'prescripcionId': instance.prescripcionId,
  'horaReal': instance.horaReal.toIso8601String(),
  'resultado': _$ResultadoAdministracionEnumMap[instance.resultado]!,
  'dosisAdministrada': instance.dosisAdministrada,
  'viaAdministrada': instance.viaAdministrada,
  'observaciones': instance.observaciones,
};
