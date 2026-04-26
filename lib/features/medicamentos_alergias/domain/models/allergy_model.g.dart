// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AllergyModel _$AllergyModelFromJson(Map<String, dynamic> json) =>
    _AllergyModel(
      id: json['id'] as String,
      pacienteId: json['pacienteId'] as String,
      agenteCausante: json['agenteCausante'] as String,
      tipoReaccion: $enumDecode(_$ReactionTypeEnumMap, json['tipoReaccion']),
      severidad: $enumDecode(_$AllergySeverityEnumMap, json['severidad']),
      estado:
          $enumDecodeNullable(_$AllergyStatusEnumMap, json['estado']) ??
          AllergyStatus.activa,
      fechaDiagnostico: json['fechaDiagnostico'] == null
          ? null
          : DateTime.parse(json['fechaDiagnostico'] as String),
      observaciones: json['observaciones'] as String?,
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
      creadoPor: json['creadoPor'] as String?,
    );

Map<String, dynamic> _$AllergyModelToJson(_AllergyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pacienteId': instance.pacienteId,
      'agenteCausante': instance.agenteCausante,
      'tipoReaccion': _$ReactionTypeEnumMap[instance.tipoReaccion]!,
      'severidad': _$AllergySeverityEnumMap[instance.severidad]!,
      'estado': _$AllergyStatusEnumMap[instance.estado]!,
      'fechaDiagnostico': instance.fechaDiagnostico?.toIso8601String(),
      'observaciones': instance.observaciones,
      'creadoEn': instance.creadoEn?.toIso8601String(),
      'creadoPor': instance.creadoPor,
    };

const _$ReactionTypeEnumMap = {
  ReactionType.anafilaxia: 'anafilaxia',
  ReactionType.urticaria: 'urticaria',
  ReactionType.angioedema: 'angioedema',
  ReactionType.intolerancia: 'intolerancia',
  ReactionType.otra: 'otra',
};

const _$AllergySeverityEnumMap = {
  AllergySeverity.leve: 'leve',
  AllergySeverity.moderada: 'moderada',
  AllergySeverity.grave: 'grave',
  AllergySeverity.mortal: 'mortal',
};

const _$AllergyStatusEnumMap = {
  AllergyStatus.activa: 'activa',
  AllergyStatus.inactiva: 'inactiva',
};

_CreateAllergyRequest _$CreateAllergyRequestFromJson(
  Map<String, dynamic> json,
) => _CreateAllergyRequest(
  pacienteId: json['pacienteId'] as String,
  agenteCausante: json['agenteCausante'] as String,
  tipoReaccion: $enumDecode(_$ReactionTypeEnumMap, json['tipoReaccion']),
  severidad: $enumDecode(_$AllergySeverityEnumMap, json['severidad']),
  fechaDiagnostico: json['fechaDiagnostico'] == null
      ? null
      : DateTime.parse(json['fechaDiagnostico'] as String),
  observaciones: json['observaciones'] as String?,
);

Map<String, dynamic> _$CreateAllergyRequestToJson(
  _CreateAllergyRequest instance,
) => <String, dynamic>{
  'pacienteId': instance.pacienteId,
  'agenteCausante': instance.agenteCausante,
  'tipoReaccion': _$ReactionTypeEnumMap[instance.tipoReaccion]!,
  'severidad': _$AllergySeverityEnumMap[instance.severidad]!,
  'fechaDiagnostico': instance.fechaDiagnostico?.toIso8601String(),
  'observaciones': instance.observaciones,
};

_MedicationModel _$MedicationModelFromJson(Map<String, dynamic> json) =>
    _MedicationModel(
      id: json['id'] as String,
      nombreGenerico: json['nombreGenerico'] as String,
      nombreComercial: json['nombreComercial'] as String?,
      categoria: json['categoria'] as String?,
    );

Map<String, dynamic> _$MedicationModelToJson(_MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombreGenerico': instance.nombreGenerico,
      'nombreComercial': instance.nombreComercial,
      'categoria': instance.categoria,
    };
