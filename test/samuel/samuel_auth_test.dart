

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

  const correoValido    = 'samuel.guerrero@sgp.com';
  const contrasenaOk    = 'Sgp#2025';
  const contrasenaWrong = 'wrong_pass';

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

  // APA-34 — T-01
  group('APA-34 | T-01 — Login exitoso con credenciales válidas', () {
    test('isAuthenticated = true cuando no hay MFA', () async {
      when(mockRepo.login(any)).thenAnswer((_) async => LoginResponse(
        requiresMfa: false, accessToken: 'valid.jwt', refreshToken: 'valid.refresh',
        user: usuarioMedico,
      ));
      await notifier.login(correo: correoValido, contrasena: contrasenaOk);
      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.user?.nombre, 'Samuel Guerrero');
    });

    test('pendingMfa = true cuando el servidor exige OTP', () async {
      when(mockRepo.login(any)).thenAnswer((_) async => const LoginResponse(requiresMfa: true));
      await notifier.login(correo: correoValido, contrasena: contrasenaOk);
      expect(notifier.state.pendingMfa, isTrue);
      expect(notifier.state.correoMfa, correoValido);
    });
  });

  // APA-35 — T-02
  group('APA-35 | T-02 — Bloqueo tras 5 intentos fallidos', () {
    test('lanza excepción con "bloqueada" cuando el servidor devuelve 423', () {
      when(mockRepo.login(any)).thenThrow(
        Exception('Cuenta bloqueada. Intente de nuevo en 30 minuto(s).'));
      expect(
        () => notifier.login(correo: correoValido, contrasena: contrasenaWrong),
        throwsA(predicate<Exception>((e) => e.toString().contains('bloqueada'))),
      );
    });

    test('el estado NO cambia a autenticado después del bloqueo', () async {
      when(mockRepo.login(any)).thenThrow(Exception('Cuenta bloqueada temporalmente.'));
      try { await notifier.login(correo: correoValido, contrasena: contrasenaWrong); } catch (_) {}
      expect(notifier.state.isAuthenticated, isFalse);
    });
  });

  // APA-36 — T-03
  group('APA-36 | T-03 — OTP válido completa la autenticación', () {
    setUp(() async {
      when(mockRepo.login(any)).thenAnswer((_) async => const LoginResponse(requiresMfa: true));
      await notifier.login(correo: correoValido, contrasena: contrasenaOk);
    });

    test('isAuthenticated = true tras OTP correcto', () async {
      when(mockRepo.verifyOtp(correo: anyNamed('correo'), otp: anyNamed('otp')))
          .thenAnswer((_) async => LoginResponse(
            requiresMfa: false, accessToken: 'new.token',
            refreshToken: 'new.refresh', user: usuarioMedico,
          ));
      await notifier.verifyOtp('482917');
      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.pendingMfa, isFalse);
    });
  });

}
