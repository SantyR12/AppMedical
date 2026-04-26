import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/verify_email_screen.dart';
import '../features/auth/presentation/screens/mfa_screen.dart';
import '../features/auth/providers/auth_provider.dart';

/// Rutas nombradas de la app — usar siempre estas constantes,
/// nunca strings sueltos.
class AppRoutes {
  AppRoutes._();

  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const mfa = '/mfa';

  // Sprint 2 — se añadirán cuando Santiago y Paulo suban sus módulos
  static const dashboard = '/dashboard';
  static const patients = '/patients';
  static const newPatient = '/patients/new';
  static const patientDetail = '/patients/:id';
  static const allergies = '/patients/:id/allergies';
  static const prescriptions = '/patients/:id/prescriptions';
}

/// Provider del router. Al observar [authStateProvider], go_router
/// re-evalúa automáticamente el redirect cada vez que el estado de
/// autenticación cambia (login, logout, token expirado).
final routerProvider = Provider<GoRouter>((ref) {
  // Listenable que activa la re-evaluación del redirect
  final authNotifier = ref.watch(authStateProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authNotifier,
    debugLogDiagnostics: true, // útil en desarrollo, quitar en producción

    // -------------------------------------------------------------------------
    // GUARD GLOBAL: redirige según el estado de autenticación
    // -------------------------------------------------------------------------
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isOnAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.verifyEmail ||
          state.matchedLocation == AppRoutes.mfa;

      // Sin sesión → siempre al login
      if (!authState.isAuthenticated && !isOnAuthRoute) {
        return AppRoutes.login;
      }

      // Con sesión válida → no dejar entrar a rutas de auth
      if (authState.isAuthenticated && isOnAuthRoute) {
        return AppRoutes.dashboard;
      }

      // En espera de MFA → forzar pantalla MFA
      if (authState.pendingMfa &&
          state.matchedLocation != AppRoutes.mfa) {
        return AppRoutes.mfa;
      }

      return null; // sin redirección
    },

    routes: [
      // -----------------------------------------------------------------------
      // MÓDULO AUTH — Samuel (PB-01, PB-02, PB-03, PB-04)
      // -----------------------------------------------------------------------
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        name: 'verifyEmail',
        builder: (context, state) {
          // Recibe el email por queryParam para mostrarlo en la pantalla
          final email = state.uri.queryParameters['email'] ?? '';
          return VerifyEmailScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.mfa,
        name: 'mfa',
        builder: (context, state) => const MfaScreen(),
      ),

      // -----------------------------------------------------------------------
      // DASHBOARD — placeholder hasta Sprint 2
      // -----------------------------------------------------------------------
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const _DashboardPlaceholder(),
      ),
    ],

    // Pantalla de error de navegación
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Ruta no encontrada: ${state.error}'),
      ),
    ),
  );
});

/// Placeholder del dashboard — se reemplaza en Sprint 2 con la pantalla real
class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SGP — Dashboard')),
      body: const Center(
        child: Text('Dashboard — Sprint 2'),
      ),
    );
  }
}
