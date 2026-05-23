import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/soap_note_model.dart';

class SoapNoteRepository {
  SoapNoteRepository({required this.dio});

  final Dio dio;

  Future<List<SoapNoteModel>> getNotesByPatientId(String pacienteId) async {
    try {
      final response = await dio.get('/notas-soap/paciente/$pacienteId');
      final list = response.data as List<dynamic>;
      return list
          .map((e) => SoapNoteModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<SoapNoteModel> createNote(CreateSoapNoteRequest request) async {
    try {
      final response = await dio.post('/notas-soap', data: request.toJson());
      return SoapNoteModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    final msg = e.response?.data?['message'] as String? ?? 'Error desconocido';
    switch (e.response?.statusCode) {
      case 404:
        return Exception('Nota SOAP no encontrada');
      case null:
        return Exception('Sin conexión a internet');
      default:
        return Exception(msg);
    }
  }
}

final soapNoteRepositoryProvider = Provider<SoapNoteRepository>((ref) {
  return SoapNoteRepository(dio: ref.watch(dioClientProvider));
});
