import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sgp_app/features/admin/presentation/screens/admin_create_user_screen.dart';
import 'package:sgp_app/features/admin/presentation/screens/admin_users_screen.dart';
import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/auth/presentation/screens/login_screen.dart';
import 'package:sgp_app/features/auth/presentation/screens/register_screen.dart';
import 'package:sgp_app/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:sgp_app/features/auth/presentation/screens/mfa_screen.dart';
import 'package:sgp_app/features/auth/presentation/screens/new_patient_screen.dart';
import 'package:sgp_app/features/auth/providers/auth_provider.dart';
import 'package:sgp_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:sgp_app/features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:sgp_app/features/diagnosticos/presentation/screens/problem_list_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/patient_search_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/patient_detail_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/consultation_history_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/soap_note_form_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/soap_note_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/diagnosis_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/mar_screen.dart';
import 'package:sgp_app/features/historial/presentation/screens/attachments_screen.dart';
import 'package:sgp_app/features/medicamentos_alergias/presentation/screens/allergy_form_screen.dart';
import 'package:sgp_app/features/medicamentos_alergias/presentation/screens/medication_history_screen.dart';
import 'package:sgp_app/features/medicamentos_alergias/presentation/screens/prescription_form_screen.dart';

/// Rutas nombradas de la app — usar siempre estas constantes,
/// nunca strings sueltos.
class AppRoutes {
  AppRoutes._();

  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const mfa = '/mfa';

  static const adminDashboard = '/admin';
  static const dashboard = '/dashboard';
  static const patients = '/patients';
  static const newPatient = '/patients/new';
  static const patientDetail = '/patients/:id';
  static const allergies = '/patients/:id/allergies';
  static const prescriptions = '/patients/:id/prescriptions';

  // Historial & notas
  static const consultationHistory = '/patients/:id/historial/:hcId';
  static const soapNoteForm = '/patients/:id/historial/:hcId/nueva-nota';

  // Nuevas pantallas Sprint 2
  static const adminCreateUser = '/admin/crear-usuario';
  static const adminUsers = '/admin/usuarios';
  static const patientSoap = '/patients/:id/soap';
  static const patientDiagnosticos = '/patients/:id/diagnosticos';
  static const patientMar = '/patients/:id/mar';
  static const patientAdjuntos = '/patients/:id/adjuntos';
}

/// Provider del router.
final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authStateProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authNotifier,
    debugLogDiagnostics: true,

    redirect: (context, state) {
      final authState = ref.read(authStateProvider).state;
      final loc = state.matchedLocation;
      final role = authState.user?.rol;

      // MFA pendiente → forzar pantalla MFA
      if (authState.pendingMfa && loc != AppRoutes.mfa) {
        return AppRoutes.mfa;
      }

      final isPublicRoute = loc == AppRoutes.login ||
          loc == AppRoutes.verifyEmail ||
          loc == AppRoutes.mfa;

      // Sin sesión activa → solo rutas públicas
      if (!authState.isAuthenticated && !isPublicRoute) {
        return AppRoutes.login;
      }

      // Con sesión → salir de pantallas de auth
      if (authState.isAuthenticated && isPublicRoute) {
        return role == UserRole.admin
            ? AppRoutes.adminDashboard
            : AppRoutes.dashboard;
      }

      // /admin/* → solo admins
      if (loc.startsWith('/admin') &&
          authState.isAuthenticated &&
          role != UserRole.admin) {
        return AppRoutes.dashboard;
      }

      return null;
    },

    routes: [
      // ── Auth ────────────────────────────────────────────────────────────────
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
          final email = state.uri.queryParameters['email'] ?? '';
          return VerifyEmailScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.mfa,
        name: 'mfa',
        builder: (context, state) => const MfaScreen(),
      ),

      // ── Dashboard ────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // ── Pacientes ────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.patients,
        name: 'patients',
        builder: (context, state) => const PatientSearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.newPatient,
        name: 'newPatient',
        builder: (context, state) => const NewPatientScreen(),
      ),
      GoRoute(
        path: AppRoutes.patientDetail,
        name: 'patientDetail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PatientDetailScreen(pacienteId: id);
        },
      ),

      // ── Alergias & Prescripciones ────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.allergies,
        name: 'allergies',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AllergyFormScreen(pacienteId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.prescriptions,
        name: 'prescriptions',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return MedicationHistoryScreen(pacienteId: id);
        },
      ),

      // ── Historial clínico (versiones del equipo) ─────────────────────────────
      GoRoute(
        path: AppRoutes.consultationHistory,
        name: 'consultationHistory',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final hcId = state.pathParameters['hcId'] ?? '';
          return ConsultationHistoryScreen(
              pacienteId: id, historiaClinicaId: hcId);
        },
      ),
      GoRoute(
        path: AppRoutes.soapNoteForm,
        name: 'soapNoteForm',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final hcId = state.pathParameters['hcId'] ?? '';
          return SoapNoteFormScreen(pacienteId: id, historiaClinicaId: hcId);
        },
      ),

      // ── Sprint 2: nuevas pantallas ────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.adminCreateUser,
        name: 'adminCreateUser',
        builder: (context, state) => const AdminCreateUserScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminUsers,
        name: 'adminUsers',
        builder: (context, state) => const AdminUsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.patientSoap,
        name: 'patientSoap',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final historiaId = state.uri.queryParameters['historiaId'] ?? '';
          return SoapNoteScreen(pacienteId: id, historiaClinicaId: historiaId);
        },
      ),
      GoRoute(
        path: AppRoutes.patientDiagnosticos,
        name: 'patientDiagnosticos',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final historiaId = state.uri.queryParameters['historiaId'] ?? '';
          return DiagnosisScreen(pacienteId: id, historiaClinicaId: historiaId);
        },
      ),
      GoRoute(
        path: AppRoutes.patientMar,
        name: 'patientMar',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return MarScreen(pacienteId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.patientAdjuntos,
        name: 'patientAdjuntos',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AttachmentsScreen(pacienteId: id);
        },
      ),
      GoRoute(
        path: '/patients/:id/diagnosticos-lista',
        name: 'problemList',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final hcId = state.uri.queryParameters['hcId'] ?? '';
          return ProblemListScreen(pacienteId: id, historiaClinicaId: hcId);
        },
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Ruta no encontrada: ${state.error}'),
      ),
    ),
  );
});
