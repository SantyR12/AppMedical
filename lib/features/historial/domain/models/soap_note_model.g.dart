// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soap_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SoapNoteModel _$SoapNoteModelFromJson(Map<String, dynamic> json) =>
    _SoapNoteModel(
      id: json['id'] as String,
      historiaClinicaId: json['historiaClinicaId'] as String,
      pacienteId: json['pacienteId'] as String,
      subjetivo: json['subjetivo'] as String,
      objetivo: json['objetivo'] as String,
      analisis: json['analisis'] as String,
      plan: json['plan'] as String,
      creadoPor: json['creadoPor'] as String?,
      creadoEn: json['creadoEn'] == null
          ? null
          : DateTime.parse(json['creadoEn'] as String),
    );

Map<String, dynamic> _$SoapNoteModelToJson(_SoapNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'historiaClinicaId': instance.historiaClinicaId,
      'pacienteId': instance.pacienteId,
      'subjetivo': instance.subjetivo,
      'objetivo': instance.objetivo,
      'analisis': instance.analisis,
      'plan': instance.plan,
      'creadoPor': instance.creadoPor,
      'creadoEn': instance.creadoEn?.toIso8601String(),
    };

_CreateSoapNoteRequest _$CreateSoapNoteRequestFromJson(
  Map<String, dynamic> json,
) => _CreateSoapNoteRequest(
  historiaClinicaId: json['historiaClinicaId'] as String,
  pacienteId: json['pacienteId'] as String,
  subjetivo: json['subjetivo'] as String,
  objetivo: json['objetivo'] as String,
  analisis: json['analisis'] as String,
  plan: json['plan'] as String,
);

Map<String, dynamic> _$CreateSoapNoteRequestToJson(
  _CreateSoapNoteRequest instance,
) => <String, dynamic>{
  'historiaClinicaId': instance.historiaClinicaId,
  'pacienteId': instance.pacienteId,
  'subjetivo': instance.subjetivo,
  'objetivo': instance.objetivo,
  'analisis': instance.analisis,
  'plan': instance.plan,
};
