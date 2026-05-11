import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/allergy_model.dart';
import '../../domain/models/prescription_model.dart';
import '../../domain/repositories/allergy_repository_interface.dart';
import '../../data/repositories/prescription_repository.dart';

/// ══════════════════════════════════════════════════════════════════════════
/// MOCK DEL REPOSITORIO DE ALERGIAS
/// ══════════════════════════════════════════════════════════════════════════
///
/// CÓMO ACTIVAR en allergy_repository.dart:
///   final allergyRepositoryProvider = Provider<IAllergyRepository>((ref) {
///     return MockAllergyRepository();  // ← activar
///   });
/// ══════════════════════════════════════════════════════════════════════════

class MockAllergyRepository implements IAllergyRepository {
  static const _delay = Duration(milliseconds: 500);

  // Alergias pre-cargadas — pac-001 tiene una alergia activa para demo
  final List<AllergyModel> _alergias = [
    AllergyModel(
      id: 'alg-001',
      pacienteId: 'pac-001',
      agenteCausante: 'Penicilina',
      tipoReaccion: ReactionType.anafilaxia,
      severidad: AllergySeverity.grave,
      estado: AllergyStatus.activa,
      fechaDiagnostico: DateTime(2022, 6, 10),
      observaciones: 'Reacción severa documentada en urgencias.',
      creadoEn: DateTime(2022, 6, 10),
      creadoPor: 'Dr. Juan López',
    ),
    AllergyModel(
      id: 'alg-002',
      pacienteId: 'pac-001',
      agenteCausante: 'Ibuprofeno',
      tipoReaccion: ReactionType.urticaria,
      severidad: AllergySeverity.moderada,
      estado: AllergyStatus.activa,
      creadoEn: DateTime(2023, 2, 5),
      creadoPor: 'Dr. Juan López',
    ),
  ];

  // Medicamentos para autocompletado
  final List<MedicationModel> _medicamentos = [
    MedicationModel(id: 'med-001', nombreGenerico: 'Penicilina G', nombreComercial: 'Pencid'),
    MedicationModel(id: 'med-002', nombreGenerico: 'Amoxicilina', nombreComercial: 'Amoxil'),
    MedicationModel(id: 'med-003', nombreGenerico: 'Ibuprofeno', nombreComercial: 'Advil'),
    MedicationModel(id: 'med-004', nombreGenerico: 'Acetaminofén', nombreComercial: 'Tylenol'),
    MedicationModel(id: 'med-005', nombreGenerico: 'Metformina', nombreComercial: 'Glucophage'),
    MedicationModel(id: 'med-006', nombreGenerico: 'Atorvastatina', nombreComercial: 'Lipitor'),
    MedicationModel(id: 'med-007', nombreGenerico: 'Losartán', nombreComercial: 'Cozaar'),
    MedicationModel(id: 'med-008', nombreGenerico: 'Omeprazol', nombreComercial: 'Prilosec'),
    MedicationModel(id: 'med-009', nombreGenerico: 'Azitromicina', nombreComercial: 'Zithromax'),
    MedicationModel(id: 'med-010', nombreGenerico: 'Ciprofloxacina', nombreComercial: 'Cipro'),
    MedicationModel(id: 'med-011', nombreGenerico: 'Diazepam', nombreComercial: 'Valium'),
    MedicationModel(id: 'med-012', nombreGenerico: 'Metronidazol', nombreComercial: 'Flagyl'),
    MedicationModel(id: 'med-013', nombreGenerico: 'Ranitidina'),
    MedicationModel(id: 'med-014', nombreGenerico: 'Salbutamol', nombreComercial: 'Ventolin'),
    MedicationModel(id: 'med-015', nombreGenerico: 'Prednisona', nombreComercial: 'Deltasone'),
  ];

  @override
  Future<AllergyModel> createAllergy(CreateAllergyRequest request) async {
    await Future.delayed(_delay);

    final nueva = AllergyModel(
      id: 'alg-${DateTime.now().millisecondsSinceEpoch}',
      pacienteId: request.pacienteId,
      agenteCausante: request.agenteCausante,
      tipoReaccion: request.tipoReaccion,
      severidad: request.severidad,
      estado: AllergyStatus.activa,
      fechaDiagnostico: request.fechaDiagnostico,
      observaciones: request.observaciones,
      creadoEn: DateTime.now(),
      creadoPor: 'Dr. Juan López',
    );
    _alergias.add(nueva);
    return nueva;
  }

  @override
  Future<List<AllergyModel>> getAllergiesByPatient(
      String pacienteId) async {
    await Future.delayed(_delay);
    return _alergias.where((a) => a.pacienteId == pacienteId).toList();
  }

  @override
  Future<AllergyModel> updateAllergyStatus({
    required String allergyId,
    required AllergyStatus newStatus,
  }) async {
    await Future.delayed(_delay);

    final idx = _alergias.indexWhere((a) => a.id == allergyId);
    if (idx == -1) throw Exception('Alergia no encontrada');

    final updated = _alergias[idx].copyWith(estado: newStatus);
    _alergias[idx] = updated;
    return updated;
  }

  @override
  Future<List<MedicationModel>> searchMedications(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _medicamentos
        .where((m) =>
            m.nombreGenerico
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            (m.nombreComercial
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false))
        .toList();
  }
}

final mockAllergyRepositoryProvider = Provider<IAllergyRepository>((ref) {
  return MockAllergyRepository();
});


/// ══════════════════════════════════════════════════════════════════════════
/// MOCK DEL REPOSITORIO DE PRESCRIPCIONES
/// ══════════════════════════════════════════════════════════════════════════

class MockPrescriptionRepository implements IPrescriptionRepository {
  static const _delay = Duration(milliseconds: 600);

  final List<PrescriptionModel> _prescripciones = [
    // pac-001 ya tiene Ibuprofeno activo — para demostrar alerta duplicidad
    PrescriptionModel(
      id: 'presc-001',
      pacienteId: 'pac-001',
      medicoId: 'usr-001',
      medicoNombre: 'Dr. Juan López',
      medicamentoId: 'med-003',
      medicamentoNombre: 'Ibuprofeno',
      dosis: 400,
      dosisUnidad: DoseUnit.mg,
      frecuenciaHoras: 8,
      viaAdministracion: AdministrationRoute.oral,
      duracionDias: 5,
      estado: PrescriptionStatus.activa,
      fechaPrescripcion: DateTime.now().subtract(const Duration(days: 2)),
      firmaDigital: 'sha256_mock_firma_001',
    ),
  ];

  @override
  Future<PrescriptionModel> createPrescription(
      CreatePrescriptionRequest request) async {
    await Future.delayed(_delay);

    final nueva = PrescriptionModel(
      id: 'presc-${DateTime.now().millisecondsSinceEpoch}',
      pacienteId: request.pacienteId,
      medicoId: 'usr-001',
      medicoNombre: 'Dr. Juan López',
      medicamentoId: request.medicamentoId,
      medicamentoNombre: request.medicamentoNombre,
      dosis: request.dosis,
      dosisUnidad: request.dosisUnidad,
      frecuenciaHoras: request.frecuenciaHoras,
      viaAdministracion: request.viaAdministracion,
      duracionDias: request.duracionDias,
      indicacionesEspeciales: request.indicacionesEspeciales,
      estado: PrescriptionStatus.activa,
      fechaPrescripcion: DateTime.now(),
      firmaDigital: 'sha256_mock_${DateTime.now().millisecondsSinceEpoch}',
      matriculaMedico: 'RM-2024-001',
    );
    _prescripciones.add(nueva);
    return nueva;
  }

  @override
  Future<DuplicityAlert> checkDuplicity({
    required String pacienteId,
    required String medicamentoId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final existe = _prescripciones.any(
      (p) =>
          p.pacienteId == pacienteId &&
          p.medicamentoId == medicamentoId &&
          p.estado == PrescriptionStatus.activa,
    );

    if (existe) {
      final presc = _prescripciones.firstWhere(
        (p) => p.pacienteId == pacienteId && p.medicamentoId == medicamentoId,
      );
      return DuplicityAlert(
        hasDuplicity: true,
        existingPrescriptionId: presc.id,
        medicamentoNombre: presc.medicamentoNombre,
      );
    }
    return const DuplicityAlert(hasDuplicity: false);
  }

  @override
  Future<AllergyAlert> checkAllergyAlert({
    required String pacienteId,
    required String medicamentoId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Penicilina (med-001) e Ibuprofeno (med-003) tienen alergia en pac-001
    final alergias = {
      'pac-001': ['med-001', 'med-003'],
    };

    final medConAlergia = alergias[pacienteId]?.contains(medicamentoId) ?? false;

    if (medConAlergia) {
      final nombreMed = medicamentoId == 'med-001' ? 'Penicilina G' : 'Ibuprofeno';
      final severidad = medicamentoId == 'med-001' ? 'grave' : 'moderada';
      return AllergyAlert(
        hasAllergy: true,
        allergyId: medicamentoId == 'med-001' ? 'alg-001' : 'alg-002',
        agenteCausante: nombreMed,
        severidad: severidad,
      );
    }
    return const AllergyAlert(hasAllergy: false);
  }

  @override
  Future<List<PrescriptionModel>> getActivePrescriptions(
      String pacienteId) async {
    await Future.delayed(_delay);
    return _prescripciones
        .where((p) =>
            p.pacienteId == pacienteId &&
            p.estado == PrescriptionStatus.activa)
        .toList();
  }

  @override
  Future<PrescriptionModel> cancelPrescription(
      String prescriptionId) async {
    await Future.delayed(_delay);

    final idx =
        _prescripciones.indexWhere((p) => p.id == prescriptionId);
    if (idx == -1) throw Exception('Prescripción no encontrada');

    final cancelled = _prescripciones[idx].copyWith(
      estado: PrescriptionStatus.cancelada,
    );
    _prescripciones[idx] = cancelled;
    return cancelled;
  }
}

final mockPrescriptionRepositoryProvider =
    Provider<IPrescriptionRepository>((ref) {
  return MockPrescriptionRepository();
});
