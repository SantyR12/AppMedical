import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/historial_repository.dart';
import '../domain/models/patient_model.dart';
import '../domain/repositories/historial_repository_interface.dart';

// =============================================================================
// ESTADO
// =============================================================================

class HistorialState {
  const HistorialState({
    this.record,
    this.isLoading = false,
    this.errorMessage,
  });

  final ClinicalRecordModel? record;
  final bool isLoading;
  final String? errorMessage;

  bool get hasError => errorMessage != null;

  HistorialState copyWith({
    ClinicalRecordModel? record,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HistorialState(
      record: record ?? this.record,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// =============================================================================
// PROVIDER — cargar historia clínica de un paciente
// =============================================================================

class HistorialNotifier extends StateNotifier<HistorialState> {
  HistorialNotifier(this._repository) : super(const HistorialState());

  final IHistorialRepository _repository;

  /// Carga la historia clínica de un paciente por su ID
  Future<void> loadRecord(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final record = await _repository.getRecordByPatientId(pacienteId);
      state = state.copyWith(record: record, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Archiva la historia (nunca elimina — PB-09 criterio 5)
  Future<void> archiveRecord(String recordId) async {
    state = state.copyWith(isLoading: true);
    try {
      final updated = await _repository.archiveRecord(recordId);
      state = state.copyWith(record: updated, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}

final historialProvider =
    StateNotifierProvider<HistorialNotifier, HistorialState>((ref) {
  return HistorialNotifier(ref.watch(historialRepositoryProvider));
});

// =============================================================================
// PROVIDER — búsqueda de pacientes (PB-14)
// =============================================================================

class PatientSearchState {
  const PatientSearchState({
    this.results = const [],
    this.isLoading = false,
    this.errorMessage,
    this.query = '',
    this.hasSearched = false,
  });

  final List<PatientModel> results;
  final bool isLoading;
  final String? errorMessage;
  final String query;
  final bool hasSearched;

  PatientSearchState copyWith({
    List<PatientModel>? results,
    bool? isLoading,
    String? errorMessage,
    String? query,
    bool? hasSearched,
  }) {
    return PatientSearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      query: query ?? this.query,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}

class PatientSearchNotifier extends StateNotifier<PatientSearchState> {
  PatientSearchNotifier(this._repository) : super(const PatientSearchState());

  final IHistorialRepository _repository;

  /// Busca cuando el query tiene mínimo 3 caracteres (PB-14 criterio 1)
  Future<void> search(String query) async {
    state = state.copyWith(query: query);

    if (query.trim().length < 3) {
      state = state.copyWith(results: [], hasSearched: false);
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Detectar si es número de documento o nombre
      final isNumeric = RegExp(r'^\d+$').hasMatch(query.trim());
      final params = isNumeric
          ? PatientSearchParams(numeroDocumento: query.trim())
          : PatientSearchParams(nombre: query.trim());

      final results = await _repository.searchPatients(params);
      state = state.copyWith(
        results: results,
        isLoading: false,
        hasSearched: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasSearched: true,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void clear() {
    state = const PatientSearchState();
  }
}

final patientSearchProvider =
    StateNotifierProvider<PatientSearchNotifier, PatientSearchState>((ref) {
  return PatientSearchNotifier(ref.watch(historialRepositoryProvider));
});