import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// URL base del backend. Cambiar por la IP del servidor cuando el equipo
/// levante el backend en Sprint 1.
///
/// Para pruebas locales con Android emulator usar: http://10.0.2.2:3000
/// Para pruebas locales con dispositivo físico usar: http://TU_IP_LOCAL:3000
const String kBaseUrl = 'http://127.0.0.1:3000/api';

/// Claves usadas en flutter_secure_storage
const String kAccessTokenKey = 'sgp_access_token';
const String kRefreshTokenKey = 'sgp_refresh_token';

/// Provider del cliente Dio configurado con el interceptor JWT.
/// Todos los repositorios del proyecto inyectan este provider.
final dioClientProvider = Provider<Dio>((ref) {
  final storage = const FlutterSecureStorage();
  final dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Agregar el interceptor que maneja JWT automáticamente
  dio.interceptors.add(
    JwtInterceptor(dio: dio, storage: storage),
  );

  return dio;
});

/// Interceptor JWT.
///
/// En cada request:
/// 1. Lee el access token del almacenamiento seguro
/// 2. Si quedan menos de 5 minutos para que expire → lo renueva primero (PB-06)
/// 3. Agrega el header Authorization: Bearer <token>
///
/// En cada error 401 (token expirado en el servidor):
/// 1. Intenta renovar el token con el refresh token
/// 2. Si logra renovar, reintenta el request original
/// 3. Si no puede renovar → borra los tokens (el router redirige al login)
class JwtInterceptor extends Interceptor {
  JwtInterceptor({required this.dio, required this.storage});

  final Dio dio;
  final FlutterSecureStorage storage;

  /// Minutos de anticipación para renovar el token antes de que expire
  static const int _renewBeforeMinutes = 5;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Rutas públicas — no necesitan token
    final publicPaths = [
      '/auth/login',
      '/auth/register',
      '/auth/verify-email',
      '/auth/refresh',
    ];
    if (publicPaths.any((p) => options.path.endsWith(p))) {
      return handler.next(options);
    }

    String? accessToken = await storage.read(key: kAccessTokenKey);

    if (accessToken != null) {
      // Verificar si el token expira pronto
      final expiry = JwtDecoder.getExpirationDate(accessToken);
      final minutesLeft = expiry.difference(DateTime.now()).inMinutes;

      if (minutesLeft < _renewBeforeMinutes) {
        // Renovar silenciosamente antes de que el usuario note algo
        accessToken = await _refreshAccessToken();
      }
    }

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 401 = el servidor rechazó el token (expirado o inválido)
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshAccessToken();
      if (newToken != null) {
        // Reintentar el request original con el token nuevo
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        try {
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (_) {
          // Si el reintento también falla, limpiar sesión
        }
      }
      // No se pudo renovar — limpiar tokens, el router llevará al login
      await _clearTokens();
    }

    return handler.next(err);
  }

  /// Llama al endpoint de refresh y guarda el nuevo access token.
  /// Devuelve el nuevo token o null si falla.
  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await storage.read(key: kRefreshTokenKey);
      if (refreshToken == null) return null;

      final response = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'] as String?;
      if (newAccessToken != null) {
        await storage.write(key: kAccessTokenKey, value: newAccessToken);
      }
      return newAccessToken;
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearTokens() async {
    await storage.delete(key: kAccessTokenKey);
    await storage.delete(key: kRefreshTokenKey);
  }
}
