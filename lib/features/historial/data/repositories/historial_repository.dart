import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/patient_model.dart';
import '../../domain/repositories/historial_repository_interface.dart';

class HistorialRepository implements IHistorialRepository {
  HistorialRepository({required this.dio});

  final Dio dio;

  // -------------------------------------------------------------------------
  // PB-09: Crear historia clínica
  // -------------------------------------------------------------------------
  @override
  Future<ClinicalRecordModel> createRecord(
      CreateClinicalRecordRequest request) async {
    try {
      final response = await dio.post(
        '/historial',
        data: request.toJson(),
      );
      return ClinicalRecordModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-09: Obtener historia clínica
  // -------------------------------------------------------------------------
  @override
  Future<ClinicalRecordModel> getRecordByPatientId(
      String pacienteId) async {
    try {
      final response = await dio.get('/historial/paciente/$pacienteId');
      return ClinicalRecordModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-09: Actualizar historia clínica
  // -------------------------------------------------------------------------
  @override
  Future<ClinicalRecordModel> updateRecord({
    required String recordId,
    required CreateClinicalRecordRequest data,
  }) async {
    try {
      final response = await dio.put(
        '/historial/$recordId',
        data: data.toJson(),
      );
      return ClinicalRecordModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-09 criterio 5: Archivar historia (nunca eliminar)
  // -------------------------------------------------------------------------
  @override
  Future<ClinicalRecordModel> archiveRecord(String recordId) async {
    try {
      final response = await dio.patch('/historial/$recordId/archivar');
      return ClinicalRecordModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // -------------------------------------------------------------------------
  // PB-14: Buscar pacientes
  // -------------------------------------------------------------------------
  @override
  Future<List<PatientModel>> searchPatients(
      PatientSearchParams params) async {
    try {
      final queryParams = <String, dynamic>{};
      if (params.nombre != null) queryParams['nombre'] = params.nombre;
      if (params.numeroDocumento != null) {
        queryParams['documento'] = params.numeroDocumento;
      }
      if (params.fechaNacimiento != null) {
        queryParams['fechaNacimiento'] =
            params.fechaNacimiento!.toIso8601String();
      }

      final response = await dio.get(
        '/pacientes/buscar',
        queryParameters: queryParams,
      );
      final list = response.data as List<dynamic>;
      return list
          .map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    final msg = e.response?.data?['message'] as String? ?? 'Error desconocido';
    switch (e.response?.statusCode) {
      case 404:
        return Exception('Paciente no encontrado');
      case 409:
        return Exception(
            'Ya existe un paciente con ese número y tipo de documento');
      case null:
        return Exception('Sin conexión a internet');
      default:
        return Exception(msg);
    }
  }
}

final historialRepositoryProvider =
    Provider<IHistorialRepository>((ref) {
  return HistorialRepository(dio: ref.watch(dioClientProvider));
});