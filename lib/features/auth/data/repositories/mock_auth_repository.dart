import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository_interface.dart';

/// ══════════════════════════════════════════════════════════════════════════
/// MOCK DEL REPOSITORIO DE AUTENTICACIÓN
/// ══════════════════════════════════════════════════════════════════════════
///
/// Reemplaza AuthRepository (que llama al backend real) con datos falsos.
/// Sirve para demostrar la app el 4 de mayo sin necesidad de servidor.
///
/// CÓMO ACTIVAR:
/// En auth_repository.dart, cambiar el provider a:
///
///   final authRepositoryProvider = Provider<IAuthRepository>((ref) {
///     return MockAuthRepository();   // ← activar esto
///     // return AuthRepository(...); // ← comentar esto
///   });
///
/// CÓMO DESACTIVAR (cuando el backend esté listo):
///   Volver a la línea de AuthRepository y comentar el mock.
/// ══════════════════════════════════════════════════════════════════════════

class MockAuthRepository implements IAuthRepository {
  // Simular delay de red para que se vea realista
  static const _delay = Duration(milliseconds: 800);

  // Base de datos en memoria — usuarios pre-cargados para la demo
  final List<Map<String, dynamic>> _usuarios = [
    {
      'id': 'usr-001',
      'nombre': 'Dr. Juan López',
      'correo': 'medico@sgp.com',
      'contrasena': 'Medico123',
      'rol': 'medico',
      'estado': 'activo',
    },
    {
      'id': 'usr-002',
      'nombre': 'Admin Sistema',
      'correo': 'admin@sgp.com',
      'contrasena': 'Admin123',
      'rol': 'admin',
      'estado': 'activo',
    },
    {
      'id': 'usr-003',
      'nombre': 'Enf. María Torres',
      'correo': 'enfermera@sgp.com',
      'contrasena': 'Enfer123',
      'rol': 'enfermero',
      'estado': 'activo',
    },
  ];

  // Token falso que simula un JWT válido
  static const _fakeAccessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      '.eyJ1c2VySWQiOiJ1c3ItMDAxIiwiZW1haWwiOiJtZWRpY29Ac2dwLmNvbSIsInJvbCI6Im1lZGljbyIsImlhdCI6MTcxNDAwMDAwMCwiZXhwIjo5OTk5OTk5OTk5fQ'
      '.mock_signature_sgp';

  static const _fakeRefreshToken = 'mock_refresh_token_sgp_2025';

  final _storage = const FlutterSecureStorage();

  // ─────────────────────────────────────────────────────────────────────────
  // PB-01: Crear usuario
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<UserModel> createUser(CreateUserRequest request) async {
    await Future.delayed(_delay);

    // Simular error si el correo ya existe
    final exists = _usuarios.any(
      (u) => u['correo'] == request.correo.toLowerCase(),
    );
    if (exists) {
      throw Exception('Ya existe un usuario con ese correo');
    }

    final newUser = UserModel(
      id: 'usr-${DateTime.now().millisecondsSinceEpoch}',
      nombre: request.nombre,
      correo: request.correo.toLowerCase(),
      rol: request.rol,
      estado: AccountStatus.pendiente,
      creadoEn: DateTime.now(),
    );

    _usuarios.add({
      'id': newUser.id,
      'nombre': newUser.nombre,
      'correo': newUser.correo,
      'contrasena': request.contrasenaTemp,
      'rol': request.rol.name,
      'estado': 'pendiente',
    });

    return newUser;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-02: Reenviar correo de verificación
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> resendVerificationEmail(String correo) async {
    await Future.delayed(_delay);
    // En el mock solo simulamos que fue exitoso
    // En producción aquí iría el email real
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-03: Login
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(_delay);

    final user = _usuarios.firstWhere(
      (u) =>
          u['correo'] == request.correo.toLowerCase() &&
          u['contrasena'] == request.contrasena,
      orElse: () => {},
    );

    if (user.isEmpty) {
      // Mensaje genérico — no revela cuál campo falló (PB-03 criterio 3)
      throw Exception('Correo o contraseña incorrectos');
    }

    if (user['estado'] == 'pendiente') {
      throw Exception('Cuenta pendiente de verificación');
    }

    // Login exitoso → requiere MFA (PB-04)
    return LoginResponse(
      requiresMfa: true,
      user: UserModel(
        id: user['id'] as String,
        nombre: user['nombre'] as String,
        correo: user['correo'] as String,
        rol: UserRole.values.firstWhere(
          (r) => r.name == user['rol'],
        ),
        estado: AccountStatus.activo,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-04: Verificar OTP
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<LoginResponse> verifyOtp({
    required String correo,
    required String otp,
  }) async {
    await Future.delayed(_delay);

    // En el mock aceptamos cualquier OTP de 6 dígitos
    // Para la demo: usar "123456"
    if (otp.length != 6 || int.tryParse(otp) == null) {
      throw Exception('Código OTP inválido');
    }

    // Simular OTP incorrecto si no es "123456"
    if (otp != '123456') {
      throw Exception('Código incorrecto');
    }

    final user = _usuarios.firstWhere(
      (u) => u['correo'] == correo.toLowerCase(),
      orElse: () => {},
    );

    final userModel = UserModel(
      id: user['id'] as String? ?? 'usr-001',
      nombre: user['nombre'] as String? ?? 'Usuario Demo',
      correo: correo,
      rol: UserRole.values.firstWhere(
        (r) => r.name == (user['rol'] as String? ?? 'medico'),
        orElse: () => UserRole.medico,
      ),
      estado: AccountStatus.activo,
    );

    // Guardar tokens falsos en el storage seguro
    await _storage.write(key: kAccessTokenKey, value: _fakeAccessToken);
    await _storage.write(key: kRefreshTokenKey, value: _fakeRefreshToken);
    await _storage.write(
      key: 'sgp_user_data',
      value: jsonEncode(userModel.toJson()),
    );

    return LoginResponse(
      requiresMfa: false,
      accessToken: _fakeAccessToken,
      refreshToken: _fakeRefreshToken,
      user: userModel,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-06: Refresh token
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<RefreshResponse> refreshToken(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const RefreshResponse(accessToken: _fakeAccessToken);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Logout
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> logout() async {
    await _storage.delete(key: kAccessTokenKey);
    await _storage.delete(key: kRefreshTokenKey);
    await _storage.delete(key: 'sgp_user_data');
  }

  @override
  Future<String?> getStoredAccessToken() async {
    return _storage.read(key: kAccessTokenKey);
  }

  @override
  Future<UserModel?> getStoredUser() async {
    final raw = await _storage.read(key: 'sgp_user_data');
    if (raw == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}

/// Provider del mock — activar este en lugar del real durante la demo
final mockAuthRepositoryProvider = Provider<IAuthRepository>((ref) {
  return MockAuthRepository();
});
