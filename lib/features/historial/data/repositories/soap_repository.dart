import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/soap_note_model.dart';

class SoapRepository {
  SoapRepository({required this.dio});
  final Dio dio;

  Future<List<SoapNoteModel>> getNotes(String pacienteId) async {
    final response = await dio.get('/notas-soap/paciente/$pacienteId');
    final list = response.data as List<dynamic>;
    return list.map((e) => SoapNoteModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<SoapNoteModel> createNote({
    required String historiaClinicaId,
    required String pacienteId,
    required String subjetivo,
    required String objetivo,
    required String analisis,
    required String plan,
  }) async {
    final response = await dio.post('/notas-soap', data: {
      'historiaClinicaId': historiaClinicaId,
      'pacienteId': pacienteId,
      'subjetivo': subjetivo,
      'objetivo': objetivo,
      'analisis': analisis,
      'plan': plan,
    });
    return SoapNoteModel.fromJson(response.data as Map<String, dynamic>);
  }
}

final soapRepositoryProvider = Provider<SoapRepository>(
  (ref) => SoapRepository(dio: ref.watch(dioClientProvider)),
);

final soapNotesProvider =
    FutureProvider.family<List<SoapNoteModel>, String>((ref, pacienteId) {
  return ref.watch(soapRepositoryProvider).getNotes(pacienteId);
});
