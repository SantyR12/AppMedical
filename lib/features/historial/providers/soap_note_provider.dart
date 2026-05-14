import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/soap_note_repository.dart';
import '../domain/models/soap_note_model.dart';

// =============================================================================
// ESTADO — historial de notas SOAP (PB-12)
// =============================================================================

class SoapNoteListState {
  const SoapNoteListState({
    this.notes = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isSaving = false,
  });

  final List<SoapNoteModel> notes;
  final bool isLoading;
  final String? errorMessage;
  final bool isSaving;

  bool get hasError => errorMessage != null;

  SoapNoteListState copyWith({
    List<SoapNoteModel>? notes,
    bool? isLoading,
    String? errorMessage,
    bool? isSaving,
  }) {
    return SoapNoteListState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

// =============================================================================
// NOTIFIER
// =============================================================================

class SoapNoteNotifier extends StateNotifier<SoapNoteListState> {
  SoapNoteNotifier(this._repository) : super(const SoapNoteListState());

  final SoapNoteRepository _repository;

  Future<void> loadNotes(String pacienteId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final notes = await _repository.getNotesByPatientId(pacienteId);
      state = state.copyWith(notes: notes, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<bool> createNote(CreateSoapNoteRequest request) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final note = await _repository.createNote(request);
      state = state.copyWith(
        notes: [note, ...state.notes],
        isSaving: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final soapNoteProvider =
    StateNotifierProvider<SoapNoteNotifier, SoapNoteListState>((ref) {
  return SoapNoteNotifier(ref.watch(soapNoteRepositoryProvider));
});
