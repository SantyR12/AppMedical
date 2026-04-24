import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/allergy_repository.dart';
import '../domain/models/allergy_model.dart';
import '../domain/repositories/allergy_repository_interface.dart';

// =============================================================================
// ESTADO — lista de alergias de un paciente
// =============================================================================

class AllergyListState {
  const AllergyListState({
    this.allergies = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<AllergyModel> allergies;
  final bool isLoading;
  final String? errorMessage;

  bool get hasError => errorMessage != null;

  AllergyListState copyWith({
    List<AllergyModel>? allergies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AllergyListState(
      allergies: allergies ?? this.allergies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AllergyListNotifier extends StateNotifier<AllergyListState> {
  AllergyListNotifier(this._repository) : super(const AllergyListState());

  final IAllergyRepository _repository;

  Future<void> loadAllergies(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final list = await _repository.getAllergiesByPatient(pacienteId);
      state = state.copyWith(allergies: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// PB-20 criterio 3: Cambiar estado activa/inactiva
  Future<void> toggleStatus(AllergyModel allergy) async {
    final newStatus = allergy.estado == AllergyStatus.activa
        ? AllergyStatus.inactiva
        : AllergyStatus.activa;
    try {
      final updated = await _repository.updateAllergyStatus(
        allergyId: allergy.id,
        newStatus: newStatus,
      );
      // Reemplazar en la lista local
      final updatedList = state.allergies
          .map((a) => a.id == updated.id ? updated : a)
          .toList();
      state = state.copyWith(allergies: updatedList);
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}

final allergyListProvider =
    StateNotifierProvider<AllergyListNotifier, AllergyListState>((ref) {
  return AllergyListNotifier(ref.watch(allergyRepositoryProvider));
});

// =============================================================================
// ESTADO — formulario de nueva alergia
// =============================================================================

enum AllergyFormStatus { idle, loading, success, error }

class AllergyFormState {
  const AllergyFormState({
    this.status = AllergyFormStatus.idle,
    this.errorMessage,
  });

  final AllergyFormStatus status;
  final String? errorMessage;

  bool get isLoading => status == AllergyFormStatus.loading;
  bool get isSuccess => status == AllergyFormStatus.success;
  bool get isError => status == AllergyFormStatus.error;

  AllergyFormState copyWith({
    AllergyFormStatus? status,
    String? errorMessage,
  }) {
    return AllergyFormState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class AllergyFormNotifier extends StateNotifier<AllergyFormState> {
  AllergyFormNotifier(this._repository) : super(const AllergyFormState());

  final IAllergyRepository _repository;

  Future<void> submit(CreateAllergyRequest request) async {
    state = const AllergyFormState(status: AllergyFormStatus.loading);
    try {
      await _repository.createAllergy(request);
      state = const AllergyFormState(status: AllergyFormStatus.success);
    } catch (e) {
      state = AllergyFormState(
        status: AllergyFormStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() => state = const AllergyFormState();
}

final allergyFormProvider =
    StateNotifierProvider<AllergyFormNotifier, AllergyFormState>((ref) {
  return AllergyFormNotifier(ref.watch(allergyRepositoryProvider));
});

// =============================================================================
// ESTADO — autocompletado de medicamentos (PB-20 criterio 4)
// =============================================================================

final medicationSuggestionsProvider =
    FutureProvider.family<List<MedicationModel>, String>((ref, query) async {
  if (query.length < 2) return [];
  final repo = ref.watch(allergyRepositoryProvider);
  return repo.searchMedications(query);
});
