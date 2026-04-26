// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    _EmergencyContact(
      nombre: json['nombre'] as String?,
      telefono: json['telefono'] as String?,
    );

Map<String, dynamic> _$EmergencyContactToJson(_EmergencyContact instance) =>
    <String, dynamic>{'nombre': instance.nombre, 'telefono': instance.telefono};

_PatientModel _$PatientModelFromJson(Map<String, dynamic> json) =>
    _PatientModel(
      id: json['id'] as String,
      nombreCompleto: json['nombreCompleto'] as String,
      tipoDocumento: $enumDecode(_$DocumentTypeEnumMap, json['tipoDocumento']),
      numeroDocumento: json['numeroDocumento'] as String,
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] as String),
      sexo: $enumDecode(_$SexEnumMap, json['sexo']),
      direccion: json['direccion'] as String?,
      telefono: json['telefono'] as String?,
      correo: json['correo'] as String?,
      contactoEmergencia: json['contactoEmergencia'] == null
          ? null
          : EmergencyContact.fromJson(
              json['contactoEmergencia'] as Map<String, dynamic>,
            ),
      historiaClinicaId: json['historiaClinicaId'] as String?,
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
      ultimoMedicoTratante: json['ultimoMedicoTratante'] as String?,
    );

Map<String, dynamic> _$PatientModelToJson(_PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombreCompleto': instance.nombreCompleto,
      'tipoDocumento': _$DocumentTypeEnumMap[instance.tipoDocumento]!,
      'numeroDocumento': instance.numeroDocumento,
      'fechaNacimiento': instance.fechaNacimiento.toIso8601String(),
      'sexo': _$SexEnumMap[instance.sexo]!,
      'direccion': instance.direccion,
      'telefono': instance.telefono,
      'correo': instance.correo,
      'contactoEmergencia': instance.contactoEmergencia,
      'historiaClinicaId': instance.historiaClinicaId,
      'creadoEn': instance.creadoEn?.toIso8601String(),
      'ultimoMedicoTratante': instance.ultimoMedicoTratante,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.cc: 'CC',
  DocumentType.ti: 'TI',
  DocumentType.ce: 'CE',
  DocumentType.pas: 'PAS',
};

const _$SexEnumMap = {Sex.masculino: 'M', Sex.femenino: 'F', Sex.otro: 'O'};

_ClinicalRecordModel _$ClinicalRecordModelFromJson(Map<String, dynamic> json) =>
    _ClinicalRecordModel(
      id: json['id'] as String,
      pacienteId: json['pacienteId'] as String,
      paciente: PatientModel.fromJson(json['paciente'] as Map<String, dynamic>),
      estado:
          $enumDecodeNullable(_$RecordStatusEnumMap, json['estado']) ??
          RecordStatus.activa,
      alergiasIds:
          (json['alergiasIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      medicamentosActivosIds:
          (json['medicamentosActivosIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      diagnosticosIds:
          (json['diagnosticosIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      consultasPreviasIds:
          (json['consultasPreviasIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      ultimoEditadoPor: json['ultimoEditadoPor'] as String?,
      ultimoEditadoDesde: json['ultimoEditadoDesde'] as String?,
      ultimaEdicionEn: json['ultimaEdicionEn'] == null
          ? null
          : DateTime.parse(json['ultimaEdicionEn'] as String),
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
    );

Map<String, dynamic> _$ClinicalRecordModelToJson(
  _ClinicalRecordModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'pacienteId': instance.pacienteId,
  'paciente': instance.paciente,
  'estado': _$RecordStatusEnumMap[instance.estado]!,
  'alergiasIds': instance.alergiasIds,
  'medicamentosActivosIds': instance.medicamentosActivosIds,
  'diagnosticosIds': instance.diagnosticosIds,
  'consultasPreviasIds': instance.consultasPreviasIds,
  'ultimoEditadoPor': instance.ultimoEditadoPor,
  'ultimoEditadoDesde': instance.ultimoEditadoDesde,
  'ultimaEdicionEn': instance.ultimaEdicionEn?.toIso8601String(),
  'creadoEn': instance.creadoEn?.toIso8601String(),
};

const _$RecordStatusEnumMap = {
  RecordStatus.activa: 'activa',
  RecordStatus.archivada: 'archivada',
};

_CreateClinicalRecordRequest _$CreateClinicalRecordRequestFromJson(
  Map<String, dynamic> json,
) => _CreateClinicalRecordRequest(
  nombreCompleto: json['nombreCompleto'] as String,
  tipoDocumento: $enumDecode(_$DocumentTypeEnumMap, json['tipoDocumento']),
  numeroDocumento: json['numeroDocumento'] as String,
  fechaNacimiento: DateTime.parse(json['fechaNacimiento'] as String),
  sexo: $enumDecode(_$SexEnumMap, json['sexo']),
  direccion: json['direccion'] as String?,
  telefono: json['telefono'] as String?,
  correo: json['correo'] as String?,
  contactoEmergencia: json['contactoEmergencia'] == null
      ? null
      : EmergencyContact.fromJson(
          json['contactoEmergencia'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CreateClinicalRecordRequestToJson(
  _CreateClinicalRecordRequest instance,
) => <String, dynamic>{
  'nombreCompleto': instance.nombreCompleto,
  'tipoDocumento': _$DocumentTypeEnumMap[instance.tipoDocumento]!,
  'numeroDocumento': instance.numeroDocumento,
  'fechaNacimiento': instance.fechaNacimiento.toIso8601String(),
  'sexo': _$SexEnumMap[instance.sexo]!,
  'direccion': instance.direccion,
  'telefono': instance.telefono,
  'correo': instance.correo,
  'contactoEmergencia': instance.contactoEmergencia,
};

_PatientSearchParams _$PatientSearchParamsFromJson(Map<String, dynamic> json) =>
    _PatientSearchParams(
      nombre: json['nombre'] as String?,
      numeroDocumento: json['numeroDocumento'] as String?,
      fechaNacimiento: json['fechaNacimiento'] == null
          ? null
          : DateTime.parse(json['fechaNacimiento'] as String),
    );

Map<String, dynamic> _$PatientSearchParamsToJson(
  _PatientSearchParams instance,
) => <String, dynamic>{
  'nombre': instance.nombre,
  'numeroDocumento': instance.numeroDocumento,
  'fechaNacimiento': instance.fechaNacimiento?.toIso8601String(),
};
