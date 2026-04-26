import '../models/user_model.dart';

/// Contrato del repositorio de autenticación.
///
/// Define qué operaciones existen sin importar si vienen del backend real
/// o de un mock para tests. Los providers y screens solo dependen de esta
/// interfaz, nunca de la implementación concreta.
abstract class IAuthRepository {
  /// PB-01: Crear un nuevo usuario (solo admins)
  Future<UserModel> createUser(CreateUserRequest request);

  /// PB-02: Reenviar correo de verificación
  Future<void> resendVerificationEmail(String correo);

  /// PB-03: Login con correo y contraseña
  /// Devuelve LoginResponse con requiresMfa=true si hay que pasar por OTP
  Future<LoginResponse> login(LoginRequest request);

  /// PB-04: Verificar el OTP de 6 dígitos
  Future<LoginResponse> verifyOtp({
    required String correo,
    required String otp,
  });

  /// PB-06: Renovar el access token usando el refresh token
  Future<RefreshResponse> refreshToken(String refreshToken);

  /// Cerrar sesión — invalida el refresh token en el servidor (PB-08, Sprint 2)
  Future<void> logout();

  /// Lee el access token guardado localmente
  Future<String?> getStoredAccessToken();

  /// Lee el usuario guardado en caché local
  Future<UserModel?> getStoredUser();
}
