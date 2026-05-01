import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/domain/models/allergy_model.dart';
import '../../domain/domain/models/prescription_model.dart';

// ─── INTERFAZ ────────────────────────────────────────────────────────────────

abstract class IPrescriptionRepository {
  /// PB-15: Crear prescripción digital
  Future<PrescriptionModel> createPrescription(
      CreatePrescriptionRequest request);

  /// PB-15 criterio 2: Verificar duplicidad antes de guardar
  Future<DuplicityAlert> checkDuplicity({
    required String pacienteId,
    required String medicamentoId,
  });

  /// PB-15 criterio 3: Verificar si hay alergia activa al medicamento
  Future<AllergyAlert> checkAllergyAlert({
    required String pacienteId,
    required String medicamentoId,
  });

  /// Listar prescripciones activas de un paciente
  Future<List<PrescriptionModel>> getActivePrescriptions(String pacienteId);

  /// Cancelar prescripción
  Future<PrescriptionModel> cancelPrescription(String prescriptionId);
}

// ─── IMPLEMENTACIÓN ──────────────────────────────────────────────────────────

class PrescriptionRepository implements IPrescriptionRepository {
  PrescriptionRepository({required this.dio});
  final Dio dio;

  @override
  Future<PrescriptionModel> createPrescription(
      CreatePrescriptionRequest request) async {
    try {
      final response = await dio.post(
        '/prescripciones',
        data: request.toJson(),
      );
      return PrescriptionModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<DuplicityAlert> checkDuplicity({
    required String pacienteId,
    required String medicamentoId,
  }) async {
    try {
      final response = await dio.get(
        '/prescripciones/duplicidad',
        queryParameters: {
          'pacienteId': pacienteId,
          'medicamentoId': medicamentoId,
        },
      );
      return DuplicityAlert.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<AllergyAlert> checkAllergyAlert({
    required String pacienteId,
    required String medicamentoId,
  }) async {
    try {
      final response = await dio.get(
        '/alergias/alerta',
        queryParameters: {
          'pacienteId': pacienteId,
          'medicamentoId': medicamentoId,
        },
      );
      return AllergyAlert.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<List<PrescriptionModel>> getActivePrescriptions(
      String pacienteId) async {
    try {
      final response = await dio.get(
        '/prescripciones/paciente/$pacienteId',
        queryParameters: {'estado': 'activa'},
      );
      final list = response.data as List<dynamic>;
      return list
          .map((e) =>
              PrescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<PrescriptionModel> cancelPrescription(
      String prescriptionId) async {
    try {
      final response =
          await dio.patch('/prescripciones/$prescriptionId/cancelar');
      return PrescriptionModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    final msg =
        e.response?.data?['message'] as String? ?? 'Error desconocido';
    switch (e.response?.statusCode) {
      case 409:
        return Exception('Duplicidad detectada: $msg');
      case 422:
        return Exception('Dosis inválida: $msg');
      case null:
        return Exception('Sin conexión a internet');
      default:
        return Exception(msg);
    }
  }
}

final prescriptionRepositoryProvider =
    Provider<IPrescriptionRepository>((ref) {
  return PrescriptionRepository(dio: ref.watch(dioClientProvider));
});
