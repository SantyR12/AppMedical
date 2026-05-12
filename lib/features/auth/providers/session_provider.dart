import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/dio_client.dart';
import '../providers/auth_provider.dart';

/// PB-06 · JWT con expiración de 1 hora y refresh token automático
///
/// Este provider complementa el interceptor de Dio (dio_client.dart).
/// Se encarga de:
///   1. Leer el token guardado al abrir la app y restaurar la sesión
///   2. Exponer el rol del usuario decodificado del JWT
///   3. Verificar si la sesión sigue activa (token no expirado)
///
/// El interceptor de dio_client.dart renueva automáticamente el token
/// cuando quedan menos de 5 minutos — este provider es el que la UI
/// consulta para decisiones de navegación.

// ---------------------------------------------------------------------------
// Leer el rol del usuario desde el JWT sin llamar al backend
// ---------------------------------------------------------------------------

/// Decodifica el JWT guardado y devuelve el rol del usuario.
/// Retorna null si no hay token o si está expirado.
Future<String?> getRolFromToken() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: kAccessTokenKey);
  if (token == null) return null;

  try {
    // Verificar que no esté expirado antes de decodificar
    if (JwtDecoder.isExpired(token)) return null;

    final payload = JwtDecoder.decode(token);
    return payload['rol'] as String?;
  } catch (_) {
    return null;
  }
}

/// Devuelve true si hay un token válido y no expirado guardado localmente.
/// Se usa al arrancar la app para decidir si ir al login o al dashboard.
Future<bool> hasActiveSession() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: kAccessTokenKey);
  if (token == null) return false;

  try {
    return !JwtDecoder.isExpired(token);
  } catch (_) {
    return false;
  }
}

/// Provider que expone el tiempo restante del token en minutos.
/// La UI puede usarlo para mostrar un indicador de sesión si lo necesita.
final tokenExpiryProvider = FutureProvider<int>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: kAccessTokenKey);
  if (token == null) return 0;

  try {
    final expiry = JwtDecoder.getExpirationDate(token);
    final minutes = expiry.difference(DateTime.now()).inMinutes;
    return minutes < 0 ? 0 : minutes;
  } catch (_) {
    return 0;
  }
});
