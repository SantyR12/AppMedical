// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  correo: json['correo'] as String,
  rol: $enumDecode(_$UserRoleEnumMap, json['rol']),
  estado:
      $enumDecodeNullable(_$AccountStatusEnumMap, json['estado']) ??
      AccountStatus.pendiente,
  creadoPor: json['creadoPor'] as String?,
  creadoEn: json['creadoEn'] == null
      ? null
      : DateTime.parse(json['creadoEn'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'correo': instance.correo,
      'rol': _$UserRoleEnumMap[instance.rol]!,
      'estado': _$AccountStatusEnumMap[instance.estado]!,
      'creadoPor': instance.creadoPor,
      'creadoEn': instance.creadoEn?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.medico: 'medico',
  UserRole.enfermero: 'enfermero',
  UserRole.admin: 'admin',
  UserRole.farmaceutico: 'farmaceutico',
};

const _$AccountStatusEnumMap = {
  AccountStatus.pendiente: 'pendiente',
  AccountStatus.activo: 'activo',
  AccountStatus.bloqueado: 'bloqueado',
};

_CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    _CreateUserRequest(
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      contrasenaTemp: json['contrasenaTemp'] as String,
      rol: $enumDecode(_$UserRoleEnumMap, json['rol']),
    );

Map<String, dynamic> _$CreateUserRequestToJson(_CreateUserRequest instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'correo': instance.correo,
      'contrasenaTemp': instance.contrasenaTemp,
      'rol': _$UserRoleEnumMap[instance.rol]!,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      correo: json['correo'] as String,
      contrasena: json['contrasena'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{
      'correo': instance.correo,
      'contrasena': instance.contrasena,
    };

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      requiresMfa: json['requiresMfa'] as bool,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{
      'requiresMfa': instance.requiresMfa,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_RefreshResponse _$RefreshResponseFromJson(Map<String, dynamic> json) =>
    _RefreshResponse(accessToken: json['accessToken'] as String);

Map<String, dynamic> _$RefreshResponseToJson(_RefreshResponse instance) =>
    <String, dynamic>{'accessToken': instance.accessToken};
