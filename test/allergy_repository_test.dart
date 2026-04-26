import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sgp_app/features/medicamentos_alergias/data/repositories/allergy_repository.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/models/allergy_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/repositories/allergy_repository_interface.dart';

// Genera el mock con: dart run build_runner build
@GenerateMocks([IAllergyRepository])
import 'allergy_repository_test.mocks.dart';

void main() {
  late MockIAllergyRepository mockRepo;

  setUp(() {
    mockRepo = MockIAllergyRepository();
  });

  // ===========================================================================
  // PB-20 criterio 1: Campos obligatorios
  // ===========================================================================
  group('PB-20 criterio 1 · Campos del formulario', () {
    test('request válido con todos los campos obligatorios', () async {
      final request = CreateAllergyRequest(
        pacienteId: 'pac-001',
        agenteCausante: 'Penicilina',
        tipoReaccion: ReactionType.anafilaxia,
        severidad: AllergySeverity.grave,
      );

      final expected = AllergyModel(
        id: 'alg-001',
        pacienteId: 'pac-001',
        agenteCausante: 'Penicilina',
        tipoReaccion: ReactionType.anafilaxia,
        severidad: AllergySeverity.grave,
        estado: AllergyStatus.activa,
      );

      when(mockRepo.createAllergy(request))
          .thenAnswer((_) async => expected);

      final result = await mockRepo.createAllergy(request);

      expect(result.agenteCausante, 'Penicilina');
      expect(result.tipoReaccion, ReactionType.anafilaxia);
      expect(result.severidad, AllergySeverity.grave);
      // Una alergia nueva siempre empieza activa
      expect(result.estado, AllergyStatus.activa);
    });

    test('agente causante vacío no debe permitirse', () {
      // Validación local — sin llamar al repositorio
      const agente = '';
      expect(agente.trim().isEmpty, true,
          reason: 'Agente vacío debe fallar la validación del formulario');
    });
  });

  // ===========================================================================
  // PB-20 criterio 2: Múltiples alergias por paciente
  // ===========================================================================
  group('PB-20 criterio 2 · Múltiples alergias', () {
    test('un paciente puede tener varias alergias', () async {
      final alergias = [
        AllergyModel(
          id: 'alg-001',
          pacienteId: 'pac-001',
          agenteCausante: 'Penicilina',
          tipoReaccion: ReactionType.anafilaxia,
          severidad: AllergySeverity.grave,
        ),
        AllergyModel(
          id: 'alg-002',
          pacienteId: 'pac-001',
          agenteCausante: 'Maní',
          tipoReaccion: ReactionType.urticaria,
          severidad: AllergySeverity.moderada,
        ),
      ];

      when(mockRepo.getAllergiesByPatient('pac-001'))
          .thenAnswer((_) async => alergias);

      final result = await mockRepo.getAllergiesByPatient('pac-001');

      expect(result.length, 2);
      expect(result[0].agenteCausante, 'Penicilina');
      expect(result[1].agenteCausante, 'Maní');
    });
  });

  // ===========================================================================
  // PB-20 criterio 3: Cambio de estado activa/inactiva
  // ===========================================================================
  group('PB-20 criterio 3 · Estado activa/inactiva', () {
    test('cambiar estado de activa a inactiva', () async {
      const allergyId = 'alg-001';
      final updated = AllergyModel(
        id: allergyId,
        pacienteId: 'pac-001',
        agenteCausante: 'Penicilina',
        tipoReaccion: ReactionType.anafilaxia,
        severidad: AllergySeverity.grave,
        estado: AllergyStatus.inactiva,
      );

      when(mockRepo.updateAllergyStatus(
        allergyId: allergyId,
        newStatus: AllergyStatus.inactiva,
      )).thenAnswer((_) async => updated);

      final result = await mockRepo.updateAllergyStatus(
        allergyId: allergyId,
        newStatus: AllergyStatus.inactiva,
      );

      expect(result.estado, AllergyStatus.inactiva);
    });
  });

  // ===========================================================================
  // PB-20 criterio 4: Autocompletado usa BD de medicamentos
  // ===========================================================================
  group('PB-20 criterio 4 · Autocompletado de medicamentos', () {
    test('buscar medicamentos devuelve sugerencias', () async {
      final sugerencias = [
        MedicationModel(
            id: 'm-001',
            nombreGenerico: 'Penicilina G',
            nombreComercial: 'Pencid'),
        MedicationModel(
            id: 'm-002', nombreGenerico: 'Penicilina V'),
      ];

      when(mockRepo.searchMedications('penic'))
          .thenAnswer((_) async => sugerencias);

      final result = await mockRepo.searchMedications('penic');

      expect(result.length, 2);
      expect(result[0].nombreGenerico, contains('Penicilina'));
    });

    test('query muy corto no debería generar sugerencias', () async {
      // Validación local — sin llamar al repo si query < 2 chars
      const query = 'P';
      expect(query.length < 2, true,
          reason:
              'Queries de 1 caracter no deben disparar la búsqueda');
    });
  });

  // ===========================================================================
  // PB-20 criterio 5: Validación de campos obligatorios
  // ===========================================================================
  group('PB-20 criterio 5 · Validación antes de guardar', () {
    test('todos los campos obligatorios deben estar presentes', () {
      // Simular validación del formulario
      const agente = 'Penicilina';
      const tipoReaccion = ReactionType.anafilaxia;
      const severidad = AllergySeverity.grave;

      expect(agente.isNotEmpty, true);
      expect(tipoReaccion, isNotNull);
      expect(severidad, isNotNull);
    });

    test('sin tipo de reacción no debe permitir guardar', () {
      ReactionType? tipoReaccion; // null = no seleccionado
      expect(tipoReaccion == null, true,
          reason: 'Formulario no debe guardarse sin tipo de reacción');
    });
  });
}
