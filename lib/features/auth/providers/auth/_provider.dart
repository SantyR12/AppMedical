import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/auth_repository.dart';
import '../domain/models/user_model.dart';
import '../domain/repositories/auth_repository_interface.dart';

// =============================================================================
// ESTADO DE AUTENTICACIÓN
// =============================================================================

/// Estado global que go_router observa para decidir a qué pantalla ir.
class AuthState {
  const AuthState({
    this.isAuthenticated = false,
    this.pendingMfa = false,
    this.pendingVerification = false,
    this.user,
    this.correoMfa,
  });

  final bool isAuthenticated;

  /// true = login exitoso pero falta ingresar el OTP (PB-04)
  final bool pendingMfa;

  /// true = usuario registrado pero sin verificar correo (PB-02)
  final bool pendingVerification;

  final UserModel? user;

  /// Correo guardado temporalmente para enviar el OTP (PB-04)
  final String? correoMfa;

  AuthState copyWith({
    bool? isAuthenticated,
    bool? pendingMfa,
    bool? pendingVerification,
    UserModel? user,
    String? correoMfa,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      pendingMfa: pendingMfa ?? this.pendingMfa,
      pendingVerification: pendingVerification ?? this.pendingVerification,
      user: user ?? this.user,
      correoMfa: correoMfa ?? this.correoMfa,
    );
  }
}

// =============================================================================
// NOTIFIER — lógica de autenticación
// =============================================================================

class AuthStateNotifier extends ChangeNotifier implements Listenable {
  AuthStateNotifier(this._repository);

  final IAuthRepository _repository;

  AuthState _state = const AuthState();
  AuthState get state => _state;

  /// Verifica si hay una sesión activa al arrancar la app
  Future<void> checkStoredSession() async {
    final token = await _repository.getStoredAccessToken();
    final user = await _repository.getStoredUser();
    if (token != null && user != null) {
      _state = AuthState(isAuthenticated: true, user: user);
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // PB-03: Login
  // ---------------------------------------------------------------------------
  Future<void> login({
    required String correo,
    required String contrasena,
  }) async {
    final response = await _repository.login(
      LoginRequest(correo: correo, contrasena: contrasena),
    );

    if (response.requiresMfa) {
      // Guardar correo para usarlo al verificar el OTP (PB-04)
      _state = AuthState(pendingMfa: true, correoMfa: correo);
    } else {
      // Sin MFA — sesión activa directamente
      _state = AuthState(isAuthenticated: true, user: response.user);
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // PB-04: Verificar OTP
  // ---------------------------------------------------------------------------
  Future<void> verifyOtp(String otp) async {
    final correo = _state.correoMfa;
    if (correo == null) throw Exception('Estado MFA inválido');

    final response = await _repository.verifyOtp(
      correo: correo,
      otp: otp,
    );
    _state = AuthState(isAuthenticated: true, user: response.user);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Logout
  // ---------------------------------------------------------------------------
  Future<void> logout() async {
    await _repository.logout();
    _state = const AuthState();
    notifyListeners();
  }
}

/// Provider del estado de autenticación — observado por go_router y toda la app
final authStateProvider =
    ChangeNotifierProvider<AuthStateNotifier>((ref) {
  final notifier = AuthStateNotifier(ref.watch(authRepositoryProvider));
  // Verificar sesión guardada al iniciar
  notifier.checkStoredSession();
  return notifier;
});

// =============================================================================
// PROVIDERS DE ACCIONES ASÍNCRONAS (para mostrar loading y errores en UI)
// =============================================================================

/// Estado de una operación asíncrona de auth (idle / loading / error / success)
enum AsyncStatus { idle, loading, success, error }

class AsyncActionState {
  const AsyncActionState({
    this.status = AsyncStatus.idle,
    this.errorMessage,
  });

  final AsyncStatus status;
  final String? errorMessage;

  bool get isLoading => status == AsyncStatus.loading;
  bool get isError => status == AsyncStatus.error;
  bool get isSuccess => status == AsyncStatus.success;

  AsyncActionState copyWith({AsyncStatus? status, String? errorMessage}) {
    return AsyncActionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider para el estado del login (loading, error, success)
final loginActionProvider =
    StateNotifierProvider<LoginActionNotifier, AsyncActionState>(
  (ref) => LoginActionNotifier(ref),
);

class LoginActionNotifier extends StateNotifier<AsyncActionState> {
  LoginActionNotifier(this._ref) : super(const AsyncActionState());

  final Ref _ref;

  Future<void> login({
    required String correo,
    required String contrasena,
  }) async {
    state = const AsyncActionState(status: AsyncStatus.loading);
    try {
      await _ref
          .read(authStateProvider.notifier)
          .login(correo: correo, contrasena: contrasena);
      state = const AsyncActionState(status: AsyncStatus.success);
    } catch (e) {
      state = AsyncActionState(
        status: AsyncStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() => state = const AsyncActionState();
}

/// Provider para el estado del registro de usuario
final registerActionProvider =
    StateNotifierProvider<RegisterActionNotifier, AsyncActionState>(
  (ref) => RegisterActionNotifier(ref),
);

class RegisterActionNotifier extends StateNotifier<AsyncActionState> {
  RegisterActionNotifier(this._ref) : super(const AsyncActionState());

  final Ref _ref;

  Future<void> createUser(CreateUserRequest request) async {
    state = const AsyncActionState(status: AsyncStatus.loading);
    try {
      await _ref.read(authRepositoryProvider).createUser(request);
      state = const AsyncActionState(status: AsyncStatus.success);
    } catch (e) {
      state = AsyncActionState(
        status: AsyncStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() => state = const AsyncActionState();
}

/// Provider para el estado de verificación OTP
final mfaActionProvider =
    StateNotifierProvider<MfaActionNotifier, AsyncActionState>(
  (ref) => MfaActionNotifier(ref),
);

class MfaActionNotifier extends StateNotifier<AsyncActionState> {
  MfaActionNotifier(this._ref) : super(const AsyncActionState());

  final Ref _ref;

  Future<void> verifyOtp(String otp) async {
    state = const AsyncActionState(status: AsyncStatus.loading);
    try {
      await _ref.read(authStateProvider.notifier).verifyOtp(otp);
      state = const AsyncActionState(status: AsyncStatus.success);
    } catch (e) {
      state = AsyncActionState(
        status: AsyncStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() => state = const AsyncActionState();
}
