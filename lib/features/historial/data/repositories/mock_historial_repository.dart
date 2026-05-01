import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/patient_model.dart';
import '../../domain/repositories/historial_repository_interface.dart';

/// ══════════════════════════════════════════════════════════════════════════
/// MOCK DEL REPOSITORIO DE HISTORIAL CLÍNICO
/// ══════════════════════════════════════════════════════════════════════════
///
/// CÓMO ACTIVAR en historial_repository.dart:
///
///   final historialRepositoryProvider = Provider<IHistorialRepository>((ref) {
///     return MockHistorialRepository();  // ← activar
///     // return HistorialRepository(...); // ← comentar
///   });
/// ══════════════════════════════════════════════════════════════════════════

class MockHistorialRepository implements IHistorialRepository {
  static const _delay = Duration(milliseconds: 600);

  // Pacientes pre-cargados para la demo del 4 de mayo
  final List<PatientModel> _pacientes = [
    PatientModel(
      id: 'pac-001',
      nombreCompleto: 'Carlos Andrés Muñoz Ruiz',
      tipoDocumento: DocumentType.cc,
      numeroDocumento: '1085234567',
      fechaNacimiento: DateTime(1978, 3, 22),
      sexo: Sex.masculino,
      direccion: 'Cra 18 # 22-45, Pasto',
      telefono: '3012345678',
      correo: 'carlos.munoz@correo.com',
      contactoEmergencia: const EmergencyContact(
        nombre: 'Ana Muñoz',
        telefono: '3109876543',
      ),
      ultimoMedicoTratante: 'Dr. Juan López',
    ),
    PatientModel(
      id: 'pac-002',
      nombreCompleto: 'Laura Stefanía Benavides',
      tipoDocumento: DocumentType.cc,
      numeroDocumento: '1085298432',
      fechaNacimiento: DateTime(1995, 7, 14),
      sexo: Sex.femenino,
      direccion: 'Calle 20 # 15-30, Pasto',
      telefono: '3156789012',
      ultimoMedicoTratante: 'Dr. Juan López',
    ),
    PatientModel(
      id: 'pac-003',
      nombreCompleto: 'Miguel Ángel Torres Paz',
      tipoDocumento: DocumentType.cc,
      numeroDocumento: '7654321098',
      fechaNacimiento: DateTime(1965, 11, 8),
      sexo: Sex.masculino,
      telefono: '3187654321',
      ultimoMedicoTratante: 'Dra. Patricia Gómez',
    ),
    PatientModel(
      id: 'pac-004',
      nombreCompleto: 'Sofía Valentina Ortega',
      tipoDocumento: DocumentType.ti,
      numeroDocumento: '1023456789',
      fechaNacimiento: DateTime(2008, 5, 30),
      sexo: Sex.femenino,
      contactoEmergencia: const EmergencyContact(
        nombre: 'Pedro Ortega',
        telefono: '3001234567',
      ),
      ultimoMedicoTratante: 'Dr. Juan López',
    ),
    PatientModel(
      id: 'pac-005',
      nombreCompleto: 'Roberto Carlos Salinas',
      tipoDocumento: DocumentType.cc,
      numeroDocumento: '9876543210',
      fechaNacimiento: DateTime(1982, 9, 3),
      sexo: Sex.masculino,
      direccion: 'Av. Los Estudiantes # 8-20, Pasto',
      ultimoMedicoTratante: 'Dra. Patricia Gómez',
    ),
  ];

  // Historias clínicas en memoria
  final List<ClinicalRecordModel> _historias = [];

  MockHistorialRepository() {
    // Crear historias clínicas para los pacientes pre-cargados
    for (final p in _pacientes) {
      _historias.add(ClinicalRecordModel(
        id: 'hc-${p.id}',
        pacienteId: p.id,
        paciente: p,
        estado: RecordStatus.activa,
        alergiasIds: p.id == 'pac-001' ? ['alg-001'] : [],
        ultimoEditadoPor: 'Dr. Juan López',
        ultimoEditadoDesde: 'iPhone 14',
        ultimaEdicionEn: DateTime.now().subtract(const Duration(hours: 3)),
        creadoEn: DateTime.now().subtract(const Duration(days: 30)),
      ));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-09: Crear historia clínica
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ClinicalRecordModel> createRecord(
      CreateClinicalRecordRequest request) async {
    await Future.delayed(_delay);

    // Verificar documento único (PB-10 criterio 5)
    final existe = _pacientes.any(
      (p) =>
          p.numeroDocumento == request.numeroDocumento &&
          p.tipoDocumento == request.tipoDocumento,
    );
    if (existe) {
      throw Exception(
          'Ya existe un paciente con ese número y tipo de documento');
    }

    final nuevoPaciente = PatientModel(
      id: 'pac-${DateTime.now().millisecondsSinceEpoch}',
      nombreCompleto: request.nombreCompleto,
      tipoDocumento: request.tipoDocumento,
      numeroDocumento: request.numeroDocumento,
      fechaNacimiento: request.fechaNacimiento,
      sexo: request.sexo,
      direccion: request.direccion,
      telefono: request.telefono,
      correo: request.correo,
      contactoEmergencia: request.contactoEmergencia,
      ultimoMedicoTratante: 'Dr. Juan López',
      creadoEn: DateTime.now(),
    );

    final nuevaHistoria = ClinicalRecordModel(
      id: 'hc-${nuevoPaciente.id}',
      pacienteId: nuevoPaciente.id,
      paciente: nuevoPaciente,
      estado: RecordStatus.activa,
      ultimoEditadoPor: 'Dr. Juan López',
      ultimoEditadoDesde: 'Demo device',
      ultimaEdicionEn: DateTime.now(),
      creadoEn: DateTime.now(),
    );

    _pacientes.add(nuevoPaciente);
    _historias.add(nuevaHistoria);
    return nuevaHistoria;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-09: Obtener historia clínica
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ClinicalRecordModel> getRecordByPatientId(
      String pacienteId) async {
    await Future.delayed(_delay);

    final historia = _historias.firstWhere(
      (h) => h.pacienteId == pacienteId,
      orElse: () => throw Exception('Historia clínica no encontrada'),
    );
    return historia;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-09: Actualizar historia clínica
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ClinicalRecordModel> updateRecord({
    required String recordId,
    required CreateClinicalRecordRequest data,
  }) async {
    await Future.delayed(_delay);

    final idx = _historias.indexWhere((h) => h.id == recordId);
    if (idx == -1) throw Exception('Historia no encontrada');

    final updated = _historias[idx].copyWith(
      ultimoEditadoPor: 'Dr. Juan López',
      ultimoEditadoDesde: 'Demo device',
      ultimaEdicionEn: DateTime.now(),
    );
    _historias[idx] = updated;
    return updated;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-09 criterio 5: Archivar historia (nunca eliminar)
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ClinicalRecordModel> archiveRecord(String recordId) async {
    await Future.delayed(_delay);

    final idx = _historias.indexWhere((h) => h.id == recordId);
    if (idx == -1) throw Exception('Historia no encontrada');

    final archived = _historias[idx].copyWith(
      estado: RecordStatus.archivada,
    );
    _historias[idx] = archived;
    return archived;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PB-14: Búsqueda de pacientes
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<PatientModel>> searchPatients(
      PatientSearchParams params) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _pacientes.where((p) {
      if (params.nombre != null) {
        return p.nombreCompleto
            .toLowerCase()
            .contains(params.nombre!.toLowerCase());
      }
      if (params.numeroDocumento != null) {
        return p.numeroDocumento == params.numeroDocumento;
      }
      if (params.fechaNacimiento != null) {
        return p.fechaNacimiento.year ==
                params.fechaNacimiento!.year &&
            p.fechaNacimiento.month ==
                params.fechaNacimiento!.month &&
            p.fechaNacimiento.day == params.fechaNacimiento!.day;
      }
      return false;
    }).toList();
  }
}

final mockHistorialRepositoryProvider =
    Provider<IHistorialRepository>((ref) {
  return MockHistorialRepository();
});
