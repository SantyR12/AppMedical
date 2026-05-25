import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dio_client.dart';
import '../../domain/models/mar_model.dart';

class MarRepository {
  MarRepository({required this.dio});
  final Dio dio;

  Future<List<MarEntryModel>> getEntries(String pacienteId) async {
    final response = await dio.get('/mar/paciente/$pacienteId');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => MarEntryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<MarEntryModel> registerAdministration({
    required String prescripcionId,
    required DateTime horaReal,
    required MarResultado resultado,
    String? dosisAdministrada,
    String? viaAdministrada,
    String? observaciones,
  }) async {
    final response = await dio.post('/mar', data: {
      'prescripcionId': prescripcionId,
      'horaReal': horaReal.toIso8601String(),
      'resultado': _resultadoToString(resultado),
      if (dosisAdministrada != null) 'dosisAdministrada': dosisAdministrada,
      if (viaAdministrada != null) 'viaAdministrada': viaAdministrada,
      if (observaciones != null) 'observaciones': observaciones,
    });
    return MarEntryModel.fromJson(response.data as Map<String, dynamic>);
  }

  static String _resultadoToString(MarResultado r) {
    switch (r) {
      case MarResultado.omitido:            return 'omitido';
      case MarResultado.rechazadoPaciente:  return 'rechazado_paciente';
      case MarResultado.contraindicado:     return 'contraindicado';
      case MarResultado.administrado:       return 'administrado';
    }
  }
}

final marRepositoryProvider = Provider<MarRepository>(
  (ref) => MarRepository(dio: ref.watch(dioClientProvider)),
);

final marEntriesProvider =
    FutureProvider.family<List<MarEntryModel>, String>((ref, pacienteId) {
  return ref.watch(marRepositoryProvider).getEntries(pacienteId);
});
