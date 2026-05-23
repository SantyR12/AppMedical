// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    _AttachmentModel(
      id: json['id'] as String,
      historiaClinicaId: json['historiaClinicaId'] as String,
      nombreArchivo: json['nombreArchivo'] as String,
      tipo: $enumDecode(_$AttachmentTypeEnumMap, json['tipo']),
      url: json['url'] as String,
      tamanoBytes: (json['tamanoBytes'] as num?)?.toInt(),
      subidoPor: json['subidoPor'] as String?,
      subidoEn: json['subidoEn'] == null
          ? null
          : DateTime.parse(json['subidoEn'] as String),
    );

Map<String, dynamic> _$AttachmentModelToJson(_AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'historiaClinicaId': instance.historiaClinicaId,
      'nombreArchivo': instance.nombreArchivo,
      'tipo': _$AttachmentTypeEnumMap[instance.tipo]!,
      'url': instance.url,
      'tamanoBytes': instance.tamanoBytes,
      'subidoPor': instance.subidoPor,
      'subidoEn': instance.subidoEn?.toIso8601String(),
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.pdf: 'pdf',
  AttachmentType.imagen: 'imagen',
};
