import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/attachment_model.dart';

class AttachmentsRepository {
  AttachmentsRepository(this._dio);
  final Dio _dio;

  Future<List<AttachmentModel>> getAttachments(String pacienteId) async {
    try {
      final response = await _dio.get('/adjuntos/$pacienteId');
      final list = response.data as List<dynamic>;
      return list
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<AttachmentModel> uploadAttachment({
    required String pacienteId,
    required String filePath,
    required String fileName,
    required String mimeType,
    String? descripcion,
  }) async {
    try {
      final formData = FormData.fromMap({
        'pacienteId': pacienteId,
        if (descripcion != null) 'descripcion': descripcion,
        'archivo': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType.parse(mimeType),
        ),
      });
      final response = await _dio.post('/adjuntos', data: formData);
      return AttachmentModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(DioException e) {
    final msg = e.response?.data?['message'] as String?;
    if (msg != null) return msg;
    if (e.response?.statusCode == 413) {
      return 'El archivo supera el límite de 10 MB';
    }
    return 'Error al procesar el archivo (${e.response?.statusCode})';
  }
}

final attachmentsRepositoryProvider =
    Provider<AttachmentsRepository>((ref) {
  return AttachmentsRepository(ref.watch(dioClientProvider));
});

final attachmentsProvider =
    FutureProvider.family<List<AttachmentModel>, String>(
        (ref, pacienteId) async {
  return ref.watch(attachmentsRepositoryProvider).getAttachments(pacienteId);
});
