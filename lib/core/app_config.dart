import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/data/repositories/mock_auth_repository.dart';
import '../features/auth/domain/repositories/auth_repository_interface.dart';
import '../features/historial/data/repositories/historial_repository.dart';
import '../features/historial/data/repositories/mock_historial_repository.dart';
import '../features/historial/domain/repositories/historial_repository_interface.dart';
import '../features/medicamentos_alergias/data/repositories/allergy_repository.dart';
import '../features/medicamentos_alergias/data/repositories/mock_allergy_prescription_repository.dart';
import '../features/medicamentos_alergias/data/repositories/prescription_repository.dart';
import '../features/medicamentos_alergias/domain/repositories/allergy_repository_interface.dart';

/// ══════════════════════════════════════════════════════════════════════════
/// SWITCH CENTRAL DE MOCKS
/// ══════════════════════════════════════════════════════════════════════════
///
/// Cambia esta línea para alternar entre datos reales y datos de demo:
///
///   static const bool useMocks = true;   ← DEMO sin backend
///   static const bool useMocks = false;  ← PRODUCCIÓN con backend real
///
/// Con un solo cambio aquí, toda la app cambia de modo.
/// ══════════════════════════════════════════════════════════════════════════

class AppConfig {
  AppConfig._();

  // ┌─────────────────────────────────────────────────────┐
  // │  CAMBIAR AQUÍ PARA DEMO O PRODUCCIÓN               │
  // └─────────────────────────────────────────────────────┘
  static const bool useMocks = true; // ← true = demo, false = backend real
}

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDERS QUE SE ADAPTAN SOLOS SEGÚN AppConfig.useMocks
// ─────────────────────────────────────────────────────────────────────────────

/// Auth — usado por auth_provider.dart
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockAuthRepository();
  }
  return AuthRepository(
    dio: ref.watch(dioClientProvider),
    storage: const FlutterSecureStorage(),
  );
});

/// Historial — usado por historial_provider.dart
final historialRepositoryProvider = Provider<IHistorialRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockHistorialRepository();
  }
  return HistorialRepository(dio: ref.watch(dioClientProvider));
});

/// Alergias — usado por allergy_provider.dart
final allergyRepositoryProvider = Provider<IAllergyRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockAllergyRepository();
  }
  return AllergyRepository(dio: ref.watch(dioClientProvider));
});

/// Prescripciones — usado por prescription screens
final prescriptionRepositoryProvider =
    Provider<IPrescriptionRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockPrescriptionRepository();
  }
  return PrescriptionRepository(dio: ref.watch(dioClientProvider));
});
