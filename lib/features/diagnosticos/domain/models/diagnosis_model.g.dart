// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiagnosisModel _$DiagnosisModelFromJson(Map<String, dynamic> json) =>
    _DiagnosisModel(
      id: json['id'] as String,
      historiaClinicaId: json['historiaClinicaId'] as String,
      pacienteId: json['pacienteId'] as String,
      codigoCie10: json['codigoCie10'] as String,
      descripcion: json['descripcion'] as String,
      tipo:
          $enumDecodeNullable(_$TipoDiagnosticoEnumMap, json['tipo']) ??
          TipoDiagnostico.presuntivo,
      estado:
          $enumDecodeNullable(_$EstadoDiagnosticoEnumMap, json['estado']) ??
          EstadoDiagnostico.activo,
      registradoPor: json['registradoPor'] as String?,
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
      actualizadoEn: json['actualizadoEn'] == null
          ? null
          : DateTime.parse(json['actualizadoEn'] as String),
    );

Map<String, dynamic> _$DiagnosisModelToJson(_DiagnosisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'historiaClinicaId': instance.historiaClinicaId,
      'pacienteId': instance.pacienteId,
      'codigoCie10': instance.codigoCie10,
      'descripcion': instance.descripcion,
      'tipo': _$TipoDiagnosticoEnumMap[instance.tipo]!,
      'estado': _$EstadoDiagnosticoEnumMap[instance.estado]!,
      'registradoPor': instance.registradoPor,
      'creadoEn': instance.creadoEn?.toIso8601String(),
      'actualizadoEn': instance.actualizadoEn?.toIso8601String(),
    };

const _$TipoDiagnosticoEnumMap = {
  TipoDiagnostico.principal: 'principal',
  TipoDiagnostico.secundario: 'secundario',
  TipoDiagnostico.presuntivo: 'presuntivo',
  TipoDiagnostico.definitivo: 'definitivo',
};

const _$EstadoDiagnosticoEnumMap = {
  EstadoDiagnostico.activo: 'activo',
  EstadoDiagnostico.resuelto: 'resuelto',
  EstadoDiagnostico.cronico: 'cronico',
};

_CreateDiagnosisRequest _$CreateDiagnosisRequestFromJson(
  Map<String, dynamic> json,
) => _CreateDiagnosisRequest(
  historiaClinicaId: json['historiaClinicaId'] as String,
  pacienteId: json['pacienteId'] as String,
  codigoCie10: json['codigoCie10'] as String,
  descripcion: json['descripcion'] as String,
  tipo: $enumDecode(_$TipoDiagnosticoEnumMap, json['tipo']),
  estado:
      $enumDecodeNullable(_$EstadoDiagnosticoEnumMap, json['estado']) ??
      EstadoDiagnostico.activo,
);

Map<String, dynamic> _$CreateDiagnosisRequestToJson(
  _CreateDiagnosisRequest instance,
) => <String, dynamic>{
  'historiaClinicaId': instance.historiaClinicaId,
  'pacienteId': instance.pacienteId,
  'codigoCie10': instance.codigoCie10,
  'descripcion': instance.descripcion,
  'tipo': _$TipoDiagnosticoEnumMap[instance.tipo]!,
  'estado': _$EstadoDiagnosticoEnumMap[instance.estado]!,
};

_Cie10Item _$Cie10ItemFromJson(Map<String, dynamic> json) => _Cie10Item(
  codigo: json['codigo'] as String,
  descripcion: json['descripcion'] as String,
);

Map<String, dynamic> _$Cie10ItemToJson(_Cie10Item instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'descripcion': instance.descripcion,
    };
