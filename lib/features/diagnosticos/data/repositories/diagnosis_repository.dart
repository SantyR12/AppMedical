import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/diagnosis_model.dart';

class DiagnosisRepository {
  DiagnosisRepository({required this.dio});
  final Dio dio;

  Future<DiagnosisModel> create(CreateDiagnosisRequest request) async {
    final response = await dio.post('/diagnosticos', data: request.toJson());
    return DiagnosisModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<DiagnosisModel>> getActiveProblems(String pacienteId) async {
    final response = await dio.get('/diagnosticos/paciente/$pacienteId/problemas');
    final list = response.data as List<dynamic>;
    return list.map((e) => DiagnosisModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<DiagnosisModel> updateEstado({
    required String id,
    required EstadoDiagnostico estado,
  }) async {
    final response = await dio.patch('/diagnosticos/$id/estado', data: {'estado': estado.name});
    return DiagnosisModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Cie10Item>> searchCie10(String query) async {
    final response = await dio.get('/cie10/buscar', queryParameters: {'q': query});
    final list = response.data as List<dynamic>;
    return list.map((e) => Cie10Item.fromJson(e as Map<String, dynamic>)).toList();
  }
}

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return DiagnosisRepository(dio: ref.watch(dioClientProvider));
});
