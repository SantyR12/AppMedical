import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'token_store.dart';

/// URL base del backend.
///
/// Para pruebas locales con Android emulator usar: http://10.0.2.2:3000
/// Para pruebas locales con dispositivo físico usar: http://TU_IP_LOCAL:3000
const String kBaseUrl = 'http://localhost:3000/api';

/// Claves usadas en flutter_secure_storage
const String kAccessTokenKey = 'sgp_access_token';
const String kRefreshTokenKey = 'sgp_refresh_token';

/// Cache en memoria para los tokens.
/// flutter_secure_storage puede no funcionar en Linux desktop (sin keyring),
/// así que guardamos los tokens en memoria como fuente primaria y en storage
/// como backup para sesiones persistentes.
class TokenCache {
  static String? accessToken;
  static String? refreshToken;

  static void clear() {
    accessToken = null;
    refreshToken = null;
  }
}

/// Provider del cliente Dio configurado con el interceptor JWT.
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

  dio.interceptors.add(
    JwtInterceptor(dio: dio, storage: storage),
  );

  return dio;
});

/// Interceptor JWT.
///
/// En cada request:
/// 1. Lee el access token del cache en memoria (o storage como fallback)
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

  static const int _renewBeforeMinutes = 5;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final publicPaths = [
      '/auth/login',
      '/auth/verify-email',
      '/auth/refresh',
    ];
    if (publicPaths.any((p) => options.path.endsWith(p))) {
      return handler.next(options);
    }

    // Leer desde memoria primero (TokenStore o TokenCache), storage como fallback
    String? accessToken = TokenStore.access ??
        TokenCache.accessToken ??
        await storage.read(key: kAccessTokenKey);

    if (accessToken != null) {
      try {
        final expiry = JwtDecoder.getExpirationDate(accessToken);
        final minutesLeft = expiry.difference(DateTime.now()).inMinutes;

        if (minutesLeft < _renewBeforeMinutes) {
          accessToken = await _refreshAccessToken();
        }
      } catch (_) {
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
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshAccessToken();
      if (newToken != null) {
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        try {
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (_) {}
      }
      await _clearTokens();
    }

    return handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = TokenStore.refresh ??
          TokenCache.refreshToken ??
          await storage.read(key: kRefreshTokenKey);
      if (refreshToken == null) return null;

      final response = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'] as String?;
      if (newAccessToken != null) {
        TokenCache.accessToken = newAccessToken;
        TokenStore.setAccess(newAccessToken);
        await storage.write(key: kAccessTokenKey, value: newAccessToken);
      }
      return newAccessToken;
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearTokens() async {
    TokenCache.clear();
    TokenStore.clear();
    await storage.delete(key: kAccessTokenKey);
    await storage.delete(key: kRefreshTokenKey);
  }
}
