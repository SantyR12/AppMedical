import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Roles disponibles en el sistema SGP (PB-01 criterio 1)
enum UserRole {
  @JsonValue('medico') medico,
  @JsonValue('enfermero') enfermero,
  @JsonValue('admin') admin,
  @JsonValue('farmaceutico') farmaceutico,
}

/// Estado de activación de la cuenta (PB-01 criterio 3 y PB-02)
enum AccountStatus {
  @JsonValue('pendiente') pendiente,   // en espera de verificar correo
  @JsonValue('activo') activo,
  @JsonValue('bloqueado') bloqueado,   // Sprint 2 — PB-05
}

/// Modelo de usuario. Generado con @freezed para tener:
/// - Constructor inmutable
/// - copyWith automático
/// - Igualdad estructural (==)
/// - fromJson / toJson para Dio
///
/// Después de editar este archivo ejecutar:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String nombre,
    required String correo,
    required UserRole rol,
    @Default(AccountStatus.pendiente) AccountStatus estado,
    String? creadoPor,
    DateTime? creadoEn,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Payload que se envía al backend para crear un nuevo usuario (PB-01)
@freezed
class CreateUserRequest with _$CreateUserRequest {
  const factory CreateUserRequest({
    required String nombre,
    required String correo,
    required String contrasenaTemp,
    required UserRole rol,
  }) = _CreateUserRequest;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);
}

/// Payload del login (PB-03)
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String correo,
    required String contrasena,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// Respuesta del login exitoso — incluye flag para saber si hay MFA pendiente
@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required bool requiresMfa,
    // Sólo presente si MFA ya fue completado (flujo sin MFA o Sprint 2)
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

/// Respuesta del refresh token (PB-06)
@freezed
class RefreshResponse with _$RefreshResponse {
  const factory RefreshResponse({
    required String accessToken,
  }) = _RefreshResponse;

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseFromJson(json);
}
