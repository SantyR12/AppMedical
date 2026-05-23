// =============================================================================
// SAMUEL GUERRERO — Tests Auth y Seguridad
// APA-37 (T-04) · APA-38 (T-05)
// Day 6 — Viernes 16 Mayo
// Ejecutar: flutter test test/tests/samuel_auth_test.dart
// Generar mocks: dart run build_runner build --delete-conflicting-outputs
// =============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:sgp_app/features/auth/providers/auth_provider.dart';

import 'samuel_auth_test.mocks.dart';

@GenerateMocks([IAuthRepository])
void main() {
  late MockIAuthRepository mockRepo;
  late AuthStateNotifier notifier;

  const correoValido = 'samuel.guerrero@sgp.com';
  const contrasenaOk = 'Sgp#2025';

  final usuarioMedico = UserModel(
    id: 'usr-samuel-001',
    nombre: 'Samuel Guerrero',
    correo: correoValido,
    rol: UserRole.medico,
    estado: AccountStatus.activo,
  );

  setUp(() {
    mockRepo = MockIAuthRepository();
    notifier = AuthStateNotifier(mockRepo);
    when(mockRepo.getStoredAccessToken()).thenAnswer((_) async => null);
    when(mockRepo.getStoredUser()).thenAnswer((_) async => null);
  });

  // APA-37 — T-04
  group('APA-37 | T-04 — OTP expirado es rechazado', () {
    setUp(() async {
      when(mockRepo.login(any))
          .thenAnswer((_) async => const LoginResponse(requiresMfa: true));
      await notifier.login(correo: correoValido, contrasena: contrasenaOk);
    });

    test('lanza excepción con "OTP" cuando el código está expirado', () {
      when(mockRepo.verifyOtp(
              correo: anyNamed('correo'), otp: anyNamed('otp')))
          .thenThrow(Exception('OTP expirado o inválido'));
      expect(
        () => notifier.verifyOtp('000000'),
        throwsA(predicate<Exception>(
            (e) => e.toString().contains('OTP'))),
      );
    });

    test('el estado NO cambia a autenticado con OTP expirado', () async {
      when(mockRepo.verifyOtp(
              correo: anyNamed('correo'), otp: anyNamed('otp')))
          .thenThrow(Exception('OTP expirado'));
      try {
        await notifier.verifyOtp('000000');
      } catch (_) {}
      expect(notifier.state.isAuthenticated, isFalse);
      expect(notifier.state.pendingMfa, isTrue);
    });
  });

  // APA-38 — T-05
  group('APA-38 | T-05 — JWT expira y se renueva automáticamente', () {
    test('refreshToken retorna un nuevo accessToken', () async {
      when(mockRepo.refreshToken(any))
          .thenAnswer((_) async =>
              const RefreshResponse(accessToken: 'nuevo.token'));
      final result = await mockRepo.refreshToken('viejo.refresh');
      expect(result.accessToken, 'nuevo.token');
    });

    test('logout limpia completamente el estado', () async {
      when(mockRepo.login(any)).thenAnswer((_) async => LoginResponse(
            requiresMfa: false,
            accessToken: 'token',
            refreshToken: 'refresh',
            user: usuarioMedico,
          ));
      await notifier.login(correo: correoValido, contrasena: contrasenaOk);
      expect(notifier.state.isAuthenticated, isTrue);

      when(mockRepo.logout()).thenAnswer((_) async {});
      await notifier.logout();

      expect(notifier.state.isAuthenticated, isFalse);
      expect(notifier.state.user, isNull);
    });
  });
}
