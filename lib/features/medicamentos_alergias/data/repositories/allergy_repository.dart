import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/allergy_model.dart';
import '../../domain/repositories/allergy_repository_interface.dart';

class AllergyRepository implements IAllergyRepository {
  AllergyRepository({required this.dio});

  final Dio dio;

  // -------------------------------------------------------------------------
  // PB-20: Crear alergia
  // -------------------------------------------------------------------------
  @override
  Future<AllergyModel> createAllergy(CreateAllergyRequest request) async {
    try {
      final response = await dio.post(
        '/alergias',
        data: request.toJson(),
      );
      return AllergyModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // Listar alergias de un paciente
  // -------------------------------------------------------------------------
  @override
  Future<List<AllergyModel>> getAllergiesByPatient(
      String pacienteId) async {
    try {
      final response =
          await dio.get('/alergias/paciente/$pacienteId');
      final list = response.data as List<dynamic>;
      return list
          .map((e) => AllergyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-20 criterio 3: Cambiar estado (solo médicos — el backend valida el rol)
  // -------------------------------------------------------------------------
  @override
  Future<AllergyModel> updateAllergyStatus({
    required String allergyId,
    required AllergyStatus newStatus,
  }) async {
    try {
      final response = await dio.patch(
        '/alergias/$allergyId/estado',
        data: {'estado': newStatus.name},
      );
      return AllergyModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-20 criterio 4 / PB-15: Autocompletado de medicamentos
  // -------------------------------------------------------------------------
  @override
  Future<List<MedicationModel>> searchMedications(String query) async {
    try {
      final response = await dio.get(
        '/medicamentos/buscar',
        queryParameters: {'q': query},
      );
      final list = response.data as List<dynamic>;
      return list
          .map((e) =>
              MedicationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    final msg =
        e.response?.data?['message'] as String? ?? 'Error desconocido';
    switch (e.response?.statusCode) {
      case 404:
        return Exception('Paciente no encontrado');
      case null:
        return Exception('Sin conexión a internet');
      default:
        return Exception(msg);
    }
  }
}

final allergyRepositoryProvider = Provider<IAllergyRepository>((ref) {
  return AllergyRepository(dio: ref.watch(dioClientProvider));
});
