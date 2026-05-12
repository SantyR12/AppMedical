import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/prescription_repository.dart';
import '../domain/models/prescription_model.dart';

class PrescriptionListState {
  const PrescriptionListState({
    this.prescriptions = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<PrescriptionModel> prescriptions;
  final bool isLoading;
  final String? errorMessage;

  bool get hasError => errorMessage != null;

  List<PrescriptionModel> get activas =>
      prescriptions.where((p) => p.estado == PrescriptionStatus.activa).toList();

  List<PrescriptionModel> get historicas =>
      prescriptions.where((p) => p.estado != PrescriptionStatus.activa).toList();

  PrescriptionListState copyWith({
    List<PrescriptionModel>? prescriptions,
    bool? isLoading,
    String? errorMessage,
  }) =>
      PrescriptionListState(
        prescriptions: prescriptions ?? this.prescriptions,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );
}

class PrescriptionListNotifier
    extends StateNotifier<PrescriptionListState> {
  PrescriptionListNotifier(this._repo) : super(const PrescriptionListState());

  final IPrescriptionRepository _repo;

  Future<void> loadPrescriptions(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final list = await _repo.getActivePrescriptions(pacienteId);
      state = state.copyWith(prescriptions: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> cancel(String prescriptionId) async {
    try {
      final updated = await _repo.cancelPrescription(prescriptionId);
      state = state.copyWith(
        prescriptions: state.prescriptions
            .map((p) => p.id == prescriptionId ? updated : p)
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}

final prescriptionListProvider = StateNotifierProvider<PrescriptionListNotifier,
    PrescriptionListState>((ref) {
  return PrescriptionListNotifier(ref.watch(prescriptionRepositoryProvider));
});
