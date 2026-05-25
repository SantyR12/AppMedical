import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/diagnosis_model.dart';

class DiagnosisRepository {
  DiagnosisRepository({required this.dio});
  final Dio dio;

  Future<List<DiagnosisModel>> getProblems(String pacienteId) async {
    final response =
        await dio.get('/diagnosticos/paciente/$pacienteId/problemas');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => DiagnosisModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DiagnosisModel> createDiagnosis({
    required String historiaClinicaId,
    required String pacienteId,
    required String codigoCie10,
    required String descripcion,
    required DiagnosisTipo tipo,
    DiagnosisEstado estado = DiagnosisEstado.activo,
  }) async {
    final response = await dio.post('/diagnosticos', data: {
      'historiaClinicaId': historiaClinicaId,
      'pacienteId': pacienteId,
      'codigoCie10': codigoCie10,
      'descripcion': descripcion,
      'tipo': tipo.name,
      'estado': estado.name,
    });
    return DiagnosisModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<DiagnosisModel> updateEstado(
      String id, DiagnosisEstado estado) async {
    final response = await dio.patch('/diagnosticos/$id/estado',
        data: {'estado': estado.name});
    return DiagnosisModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Cie10Item>> searchCie10(String query) async {
    if (query.trim().length < 2) return [];
    final response =
        await dio.get('/cie10/buscar', queryParameters: {'q': query.trim()});
    final list = response.data as List<dynamic>;
    return list
        .map((e) => Cie10Item.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>(
  (ref) => DiagnosisRepository(dio: ref.watch(dioClientProvider)),
);

final diagnosisProblemsProvider =
    FutureProvider.family<List<DiagnosisModel>, String>((ref, pacienteId) {
  return ref.watch(diagnosisRepositoryProvider).getProblems(pacienteId);
});
