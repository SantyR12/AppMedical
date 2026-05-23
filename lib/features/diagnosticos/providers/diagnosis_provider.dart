import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/diagnosis_repository.dart';
import '../domain/models/diagnosis_model.dart';

class DiagnosisState {
  const DiagnosisState({this.diagnoses = const [], this.isLoading = false, this.errorMessage});
  final List<DiagnosisModel> diagnoses;
  final bool isLoading;
  final String? errorMessage;
  bool get hasError => errorMessage != null;

  DiagnosisState copyWith({List<DiagnosisModel>? diagnoses, bool? isLoading, String? errorMessage}) =>
      DiagnosisState(
        diagnoses: diagnoses ?? this.diagnoses,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );
}

class DiagnosisNotifier extends StateNotifier<DiagnosisState> {
  DiagnosisNotifier(this._repo) : super(const DiagnosisState());
  final DiagnosisRepository _repo;

  Future<void> loadProblems(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final list = await _repo.getActiveProblems(pacienteId);
      state = state.copyWith(diagnoses: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<bool> create(CreateDiagnosisRequest request) async {
    try {
      final d = await _repo.create(request);
      state = state.copyWith(diagnoses: [d, ...state.diagnoses]);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<void> updateEstado({required String id, required EstadoDiagnostico estado}) async {
    try {
      final updated = await _repo.updateEstado(id: id, estado: estado);
      state = state.copyWith(
        diagnoses: state.diagnoses.map((d) => d.id == id ? updated : d).toList(),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final diagnosisProvider = StateNotifierProvider<DiagnosisNotifier, DiagnosisState>((ref) {
  return DiagnosisNotifier(ref.watch(diagnosisRepositoryProvider));
});
