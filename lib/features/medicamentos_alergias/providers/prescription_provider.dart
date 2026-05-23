import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/prescription_repository.dart';
import '../domain/models/prescription_model.dart';
import '../domain/models/mar_model.dart';

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

class PrescriptionState {
  const PrescriptionState({this.prescriptions = const [], this.isLoading = false, this.errorMessage});
  final List<PrescriptionModel> prescriptions;
  final bool isLoading;
  final String? errorMessage;
  bool get hasError => errorMessage != null;
  List<PrescriptionModel> get activas =>
      prescriptions.where((p) => p.estado == EstadoPrescripcion.activa).toList();
  List<PrescriptionModel> get historicas =>
      prescriptions.where((p) => p.estado != EstadoPrescripcion.activa).toList();

  PrescriptionState copyWith({
    List<PrescriptionModel>? prescriptions, bool? isLoading, String? errorMessage,
  }) => PrescriptionState(
    prescriptions: prescriptions ?? this.prescriptions,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
  );
}

class PrescriptionNotifier extends StateNotifier<PrescriptionState> {
  PrescriptionNotifier(this._repo) : super(const PrescriptionState());
  final PrescriptionRepository _repo;

  Future<void> loadPrescriptions(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final list = await _repo.getByPatient(pacienteId);
      state = state.copyWith(prescriptions: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // Retorna null si éxito, o el mensaje de error si falla (alergia/duplicado)
  Future<String?> create(CreatePrescriptionRequest request) async {
    try {
      final p = await _repo.create(request);
      state = state.copyWith(prescriptions: [p, ...state.prescriptions]);
      return null;
    } on Exception catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      state = state.copyWith(errorMessage: msg);
      return msg;
    }
  }

  Future<void> suspend(String id) async {
    try {
      final updated = await _repo.suspend(id);
      state = state.copyWith(
        prescriptions: state.prescriptions.map((p) => p.id == id ? updated : p).toList(),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final prescriptionProvider =
    StateNotifierProvider<PrescriptionNotifier, PrescriptionState>((ref) {
  return PrescriptionNotifier(ref.watch(prescriptionRepositoryProvider));
});

// Estado MAR
class MarState {
  const MarState({this.entries = const [], this.isLoading = false, this.errorMessage});
  final List<MarEntryModel> entries;
  final bool isLoading;
  final String? errorMessage;
  bool get hasError => errorMessage != null;
  List<MarEntryModel> get pendientes => entries.where((e) => e.horaReal == null).toList();

  MarState copyWith({List<MarEntryModel>? entries, bool? isLoading, String? errorMessage}) =>
      MarState(
        entries: entries ?? this.entries,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );
}

class MarNotifier extends StateNotifier<MarState> {
  MarNotifier(this._repo) : super(const MarState());
  final PrescriptionRepository _repo;

  Future<void> loadEntries(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final list = await _repo.getMarEntries(pacienteId);
      state = state.copyWith(entries: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<bool> register(RegisterMarEntryRequest request) async {
    try {
      final entry = await _repo.registerAdministration(request);
      state = state.copyWith(
        entries: state.entries.map((e) => e.id == entry.id ? entry : e).toList(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }
}

final marProvider = StateNotifierProvider<MarNotifier, MarState>((ref) {
  return MarNotifier(ref.watch(prescriptionRepositoryProvider));
});