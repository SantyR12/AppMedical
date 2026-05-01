// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    _PrescriptionModel(
      id: json['id'] as String,
      pacienteId: json['pacienteId'] as String,
      medicoId: json['medicoId'] as String,
      medicoNombre: json['medicoNombre'] as String,
      medicamentoId: json['medicamentoId'] as String,
      medicamentoNombre: json['medicamentoNombre'] as String,
      dosis: (json['dosis'] as num).toDouble(),
      dosisUnidad: $enumDecode(_$DoseUnitEnumMap, json['dosisUnidad']),
      frecuenciaHoras: (json['frecuenciaHoras'] as num).toInt(),
      viaAdministracion: $enumDecode(
        _$AdministrationRouteEnumMap,
        json['viaAdministracion'],
      ),
      duracionDias: (json['duracionDias'] as num).toInt(),
      indicacionesEspeciales: json['indicacionesEspeciales'] as String?,
      estado:
          $enumDecodeNullable(_$PrescriptionStatusEnumMap, json['estado']) ??
          PrescriptionStatus.activa,
      fechaPrescripcion: json['fechaPrescripcion'] == null
          ? null
          : DateTime.parse(json['fechaPrescripcion'] as String),
      firmaDigital: json['firmaDigital'] as String?,
      matriculaMedico: json['matriculaMedico'] as String?,
    );

Map<String, dynamic> _$PrescriptionModelToJson(_PrescriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pacienteId': instance.pacienteId,
      'medicoId': instance.medicoId,
      'medicoNombre': instance.medicoNombre,
      'medicamentoId': instance.medicamentoId,
      'medicamentoNombre': instance.medicamentoNombre,
      'dosis': instance.dosis,
      'dosisUnidad': _$DoseUnitEnumMap[instance.dosisUnidad]!,
      'frecuenciaHoras': instance.frecuenciaHoras,
      'viaAdministracion':
          _$AdministrationRouteEnumMap[instance.viaAdministracion]!,
      'duracionDias': instance.duracionDias,
      'indicacionesEspeciales': instance.indicacionesEspeciales,
      'estado': _$PrescriptionStatusEnumMap[instance.estado]!,
      'fechaPrescripcion': instance.fechaPrescripcion?.toIso8601String(),
      'firmaDigital': instance.firmaDigital,
      'matriculaMedico': instance.matriculaMedico,
    };

const _$DoseUnitEnumMap = {
  DoseUnit.mg: 'mg',
  DoseUnit.ml: 'ml',
  DoseUnit.mcg: 'mcg',
  DoseUnit.unidades: 'unidades',
};

const _$AdministrationRouteEnumMap = {
  AdministrationRoute.oral: 'oral',
  AdministrationRoute.iv: 'IV',
  AdministrationRoute.im: 'IM',
  AdministrationRoute.subcutanea: 'subcutanea',
  AdministrationRoute.topica: 'topica',
};

const _$PrescriptionStatusEnumMap = {
  PrescriptionStatus.activa: 'activa',
  PrescriptionStatus.completada: 'completada',
  PrescriptionStatus.cancelada: 'cancelada',
};

_CreatePrescriptionRequest _$CreatePrescriptionRequestFromJson(
  Map<String, dynamic> json,
) => _CreatePrescriptionRequest(
  pacienteId: json['pacienteId'] as String,
  medicamentoId: json['medicamentoId'] as String,
  medicamentoNombre: json['medicamentoNombre'] as String,
  dosis: (json['dosis'] as num).toDouble(),
  dosisUnidad: $enumDecode(_$DoseUnitEnumMap, json['dosisUnidad']),
  frecuenciaHoras: (json['frecuenciaHoras'] as num).toInt(),
  viaAdministracion: $enumDecode(
    _$AdministrationRouteEnumMap,
    json['viaAdministracion'],
  ),
  duracionDias: (json['duracionDias'] as num).toInt(),
  indicacionesEspeciales: json['indicacionesEspeciales'] as String?,
);

Map<String, dynamic> _$CreatePrescriptionRequestToJson(
  _CreatePrescriptionRequest instance,
) => <String, dynamic>{
  'pacienteId': instance.pacienteId,
  'medicamentoId': instance.medicamentoId,
  'medicamentoNombre': instance.medicamentoNombre,
  'dosis': instance.dosis,
  'dosisUnidad': _$DoseUnitEnumMap[instance.dosisUnidad]!,
  'frecuenciaHoras': instance.frecuenciaHoras,
  'viaAdministracion':
      _$AdministrationRouteEnumMap[instance.viaAdministracion]!,
  'duracionDias': instance.duracionDias,
  'indicacionesEspeciales': instance.indicacionesEspeciales,
};

_DuplicityAlert _$DuplicityAlertFromJson(Map<String, dynamic> json) =>
    _DuplicityAlert(
      hasDuplicity: json['hasDuplicity'] as bool,
      existingPrescriptionId: json['existingPrescriptionId'] as String?,
      medicamentoNombre: json['medicamentoNombre'] as String?,
    );

Map<String, dynamic> _$DuplicityAlertToJson(_DuplicityAlert instance) =>
    <String, dynamic>{
      'hasDuplicity': instance.hasDuplicity,
      'existingPrescriptionId': instance.existingPrescriptionId,
      'medicamentoNombre': instance.medicamentoNombre,
    };

_AllergyAlert _$AllergyAlertFromJson(Map<String, dynamic> json) =>
    _AllergyAlert(
      hasAllergy: json['hasAllergy'] as bool,
      allergyId: json['allergyId'] as String?,
      agenteCausante: json['agenteCausante'] as String?,
      severidad: json['severidad'] as String?,
    );

Map<String, dynamic> _$AllergyAlertToJson(_AllergyAlert instance) =>
    <String, dynamic>{
      'hasAllergy': instance.hasAllergy,
      'allergyId': instance.allergyId,
      'agenteCausante': instance.agenteCausante,
      'severidad': instance.severidad,
    };
