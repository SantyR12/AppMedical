import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/dio_client.dart';
import '../../../../core/token_store.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository_interface.dart';

/// Claves adicionales para caché local del usuario
const String kUserKey = 'sgp_user_data';

/// Implementación concreta del repositorio de autenticación.
/// Llama al backend a través de Dio y persiste tokens con flutter_secure_storage.
class AuthRepository implements IAuthRepository {
  AuthRepository({required this.dio, required this.storage});

  final Dio dio;
  final FlutterSecureStorage storage;

  // ---------------------------------------------------------------------------
  // PB-01: Crear usuario (admin)
  // ---------------------------------------------------------------------------
  @override
  Future<UserModel> createUser(CreateUserRequest request) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // PB-02: Reenviar correo de verificación
  // ---------------------------------------------------------------------------
  @override
  Future<void> resendVerificationEmail(String correo) async {
    try {
      await dio.post(
        '/auth/resend-verification',
        data: {'correo': correo},
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // PB-03: Login
  // ---------------------------------------------------------------------------
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // PB-04: Verificar OTP
  // ---------------------------------------------------------------------------
  @override
  Future<LoginResponse> verifyOtp({
    required String correo,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        '/auth/verify-otp',
        data: {'correo': correo, 'otp': otp},
      );
      final loginResponse =
          LoginResponse.fromJson(response.data as Map<String, dynamic>);

      // Persistir tokens una vez completado el flujo MFA
      if (loginResponse.accessToken != null) {
        TokenCache.accessToken = loginResponse.accessToken;
        await storage.write(
          key: kAccessTokenKey,
          value: loginResponse.accessToken,
        );
        TokenStore.setAccess(loginResponse.accessToken);
      }
      if (loginResponse.refreshToken != null) {
        TokenCache.refreshToken = loginResponse.refreshToken;
        await storage.write(
          key: kRefreshTokenKey,
          value: loginResponse.refreshToken,
        );
        TokenStore.setRefresh(loginResponse.refreshToken);
      }
      if (loginResponse.user != null) {
        await storage.write(
          key: kUserKey,
          value: jsonEncode(loginResponse.user!.toJson()),
        );
      }
      return loginResponse;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // PB-06: Refresh token
  // ---------------------------------------------------------------------------
  @override
  Future<RefreshResponse> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      return RefreshResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Logout
  // ---------------------------------------------------------------------------
  @override
  Future<void> logout() async {
    try {
      final refreshToken = TokenStore.refresh ?? await storage.read(key: kRefreshTokenKey);
      if (refreshToken != null) {
        await dio.post(
          '/auth/logout',
          data: {'refreshToken': refreshToken},
        );
      }
    } finally {
      // Siempre limpiar almacenamiento local, aunque el servidor falle
      TokenCache.clear();
      await storage.delete(key: kAccessTokenKey);
      await storage.delete(key: kRefreshTokenKey);
      await storage.delete(key: kUserKey);
      TokenStore.clear();
    }
  }

  // ---------------------------------------------------------------------------
  // Leer datos almacenados localmente
  // ---------------------------------------------------------------------------
  @override
  Future<String?> getStoredAccessToken() async {
    return storage.read(key: kAccessTokenKey);
  }

  @override
  Future<UserModel?> getStoredUser() async {
    final raw = await storage.read(key: kUserKey);
    if (raw == null) return null;
    try {
      return UserModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // PB-05: Desbloquear usuario (admin)
  // ---------------------------------------------------------------------------
  @override
  Future<void> unblockUser(String userId) async {
    try {
      await dio.patch('/auth/usuarios/$userId/desbloquear');
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Listar usuarios (admin)
  // ---------------------------------------------------------------------------
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dio.get('/auth/usuarios');
      final list = response.data as List<dynamic>;
      return list
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Convierte un DioException en un mensaje de error legible para el usuario.
  /// Los mensajes son genéricos a propósito (PB-03 criterio 3: no revelar
  /// cuál campo falló).
  Exception _mapDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage =
        e.response?.data?['message'] as String? ?? 'Error desconocido';

    switch (statusCode) {
      case 400:
        return Exception(serverMessage);
      case 401:
        return Exception('Correo o contraseña incorrectos');
      case 403:
        return Exception('No tienes permiso para realizar esta acción');
      case 409:
        return Exception('Ya existe un usuario con ese correo');
      case 423:
        final mins = e.response?.data?['bloqueadoHasta'] != null
            ? ((DateTime.parse(e.response!.data['bloqueadoHasta'].toString())
                        .difference(DateTime.now())
                        .inSeconds +
                    59) ~/
                60)
            : 15;
        return Exception('Cuenta bloqueada. Intente de nuevo en $mins minuto(s).');
      case 422:
        return Exception('Datos inválidos. Verificar el formulario.');
      case 423:
        // PB-05: cuenta bloqueada tras 5 intentos fallidos
        final until = e.response?.data?['bloqueadoHasta'] as String?;
        if (until != null) {
          final dt = DateTime.tryParse(until);
          final minutos = dt != null
              ? dt.difference(DateTime.now()).inMinutes + 1
              : 30;
          return Exception(
              'Cuenta bloqueada. Intente de nuevo en $minutos minuto(s).');
        }
        return Exception('Cuenta bloqueada temporalmente. Intente más tarde.');
      case 429:
        return Exception('Demasiados intentos. Espere unos minutos.');
      case null:
        return Exception('Sin conexión a internet');
      default:
        return Exception('Error del servidor ($statusCode)');
    }
  }
}

/// Provider del repositorio — inyecta Dio y FlutterSecureStorage
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(
    dio: ref.watch(dioClientProvider),
    storage: const FlutterSecureStorage(),
  );
});