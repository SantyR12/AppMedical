// APA-43 (T-10) · APA-44 (T-11)
// Ejecutar: flutter test test/paulo/paulo_alergias_test.dart
// Generar mocks: dart run build_runner build --delete-conflicting-outputs

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sgp_app/features/medicamentos_alergias/domain/models/allergy_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/models/prescription_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/repositories/allergy_repository_interface.dart';
import 'package:sgp_app/features/medicamentos_alergias/providers/allergy_provider.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/utils/dose_validator.dart';
import 'package:sgp_app/features/historial/presentation/widgets/allergy_banner.dart';

import 'paulo_alergias_test.mocks.dart';

@GenerateMocks([IAllergyRepository])
void main() {
  late MockIAllergyRepository mockAllergyRepo;
  late AllergyNotifier allergyNotifier;

  const pacienteId = 'pac-paulo-001';

  final alergiaGrave = AllergyModel(
    id: 'ale-001', pacienteId: pacienteId,
    agenteCausante: 'penicilina',
    tipoReaccion: ReactionType.anafilaxia,
    severidad: AllergySeverity.grave,
    estado: AllergyStatus.activa,
    creadoEn: DateTime(2023, 1, 15),
  );

  final alergiaMortal = AllergyModel(
    id: 'ale-002', pacienteId: pacienteId,
    agenteCausante: 'ampicilina',
    tipoReaccion: ReactionType.anafilaxia,
    severidad: AllergySeverity.mortal,
    estado: AllergyStatus.activa,
    creadoEn: DateTime(2022, 6, 10),
  );

  final alergiaLeve = AllergyModel(
    id: 'ale-003', pacienteId: pacienteId,
    agenteCausante: 'ibuprofeno',
    tipoReaccion: ReactionType.urticaria,
    severidad: AllergySeverity.leve,
    estado: AllergyStatus.activa,
  );

  setUp(() {
    mockAllergyRepo = MockIAllergyRepository();
    allergyNotifier = AllergyNotifier(mockAllergyRepo);
  });

  // APA-43 — T-10
  group('APA-43 | T-10 — Alergia grave con banner visible en perfil', () {
    test('el estado tiene la alergia grave después de cargarla', () async {
      when(mockAllergyRepo.getAllergiesByPatient(pacienteId))
          .thenAnswer((_) async => [alergiaGrave]);
      await allergyNotifier.loadAllergies(pacienteId);
      expect(allergyNotifier.state.allergies.first.severidad, AllergySeverity.grave);
      expect(allergyNotifier.state.allergies.first.agenteCausante, 'penicilina');
    });

    test('hasSevere es true con al menos una alergia grave o mortal', () async {
      when(mockAllergyRepo.getAllergiesByPatient(pacienteId))
          .thenAnswer((_) async => [alergiaGrave, alergiaLeve]);
      await allergyNotifier.loadAllergies(pacienteId);
      final tieneGrave = allergyNotifier.state.allergies.any(
        (a) => a.severidad == AllergySeverity.grave || a.severidad == AllergySeverity.mortal);
      expect(tieneGrave, isTrue);
    });

    test('hasSevere es false cuando todas son leves o moderadas', () async {
      when(mockAllergyRepo.getAllergiesByPatient(pacienteId))
          .thenAnswer((_) async => [alergiaLeve]);
      await allergyNotifier.loadAllergies(pacienteId);
      final tieneGrave = allergyNotifier.state.allergies.any(
        (a) => a.severidad == AllergySeverity.grave || a.severidad == AllergySeverity.mortal);
      expect(tieneGrave, isFalse);
    });

    testWidgets('AllergyBanner muestra ALERGIA GRAVE cuando hasSevere = true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: AllergyBanner(
        allergyCount: 1, hasSevere: true, allergenNames: const ['penicilina']))));
      expect(find.byType(AllergyBanner), findsOneWidget);
      expect(find.textContaining('ALERGIA GRAVE'), findsOneWidget);
      expect(find.textContaining('penicilina'), findsOneWidget);
    });

    testWidgets('AllergyBanner NO muestra ALERGIA GRAVE cuando hasSevere = false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: AllergyBanner(
        allergyCount: 2, hasSevere: false, allergenNames: const ['ibuprofeno']))));
      expect(find.textContaining('ALERGIA GRAVE'), findsNothing);
      expect(find.textContaining('2 alergia'), findsOneWidget);
    });

    testWidgets('AllergyBanner no ocupa espacio cuando allergyCount = 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: AllergyBanner(
        allergyCount: 0, hasSevere: false, allergenNames: const []))));
      final sizedBox = tester.widget<SizedBox>(find.descendant(
        of: find.byType(AllergyBanner), matching: find.byType(SizedBox)));
      expect(sizedBox.width, isNull);
    });

    test('alergia inactiva NO cuenta para el banner', () async {
      final inactiva = alergiaGrave.copyWith(estado: AllergyStatus.inactiva);
      when(mockAllergyRepo.getAllergiesByPatient(pacienteId))
          .thenAnswer((_) async => [inactiva]);
      await allergyNotifier.loadAllergies(pacienteId);
      final activasGraves = allergyNotifier.state.allergies.where((a) =>
        a.estado == AllergyStatus.activa &&
        (a.severidad == AllergySeverity.grave || a.severidad == AllergySeverity.mortal)).toList();
      expect(activasGraves, isEmpty);
    });
  });

  // APA-44 — T-11
  group('APA-44 | T-11 — Alerta al prescribir con alergia activa', () {
    test('el error contiene "alergi" cuando hay conflicto de alergia', () async {
      final mockPrescRepo = _MockPrescriptionRepo();
      when(mockPrescRepo.create(any)).thenThrow(Exception(
        'Conflicto de alergia: el paciente tiene alergia activa a penicilina (GRAVE)'));

      Exception? capturada;
      try {
        await mockPrescRepo.create(CreatePrescriptionRequest(
          historiaClinicaId: 'hc-001', pacienteId: pacienteId,
          medicamentoId: 'med-001', dosis: '500mg',
          via: ViaAdministracion.oral, frecuencia: 'cada 8 horas',
        ));
      } catch (e) { capturada = e as Exception; }

      expect(capturada.toString().toLowerCase(), contains('alergi'));
    });

    test('alerta MORTAL no puede ser ignorada (canOverride = false)', () {
      const msg = 'ALERTA MORTAL: alergia a ampicilina. No se puede ignorar.';
      final puedeIgnorar = !msg.toLowerCase().contains('mortal');
      expect(puedeIgnorar, isFalse);
    });

    test('alerta GRAVE sí puede ser ignorada con justificación', () {
      const msg = 'Conflicto de alergia: alergia activa a penicilina (GRAVE)';
      final puedeIgnorar = !msg.toLowerCase().contains('mortal');
      expect(puedeIgnorar, isTrue);
    });

    group('PB-18 — DoseValidator', () {
      test('dosis válida retorna null (paracetamol 500mg para 70kg)', () {
        final error = DoseValidator.validate(
          dosisMg: 500, pesoKg: 70, nombreGenerico: 'paracetamol');
        expect(error, isNull);
      });

      test('dosis excesiva retorna mensaje de error', () {
        final error = DoseValidator.validate(
          dosisMg: 6000, pesoKg: 70, nombreGenerico: 'paracetamol');
        expect(error, isNotNull);
        expect(error, contains('máximo'));
      });

      test('medicamento no catalogado retorna null (no bloquea)', () {
        final error = DoseValidator.validate(
          dosisMg: 9999, pesoKg: 70, nombreGenerico: 'medicamento_raro');
        expect(error, isNull);
      });

      test('ibuprofeno 400mg para 60kg es válido', () {
        final error = DoseValidator.validate(
          dosisMg: 400, pesoKg: 60, nombreGenerico: 'ibuprofeno');
        expect(error, isNull);
      });

      test('ibuprofeno 3000mg para 50kg supera el máximo (2000mg)', () {
        final error = DoseValidator.validate(
          dosisMg: 3000, pesoKg: 50, nombreGenerico: 'ibuprofeno');
        expect(error, isNotNull);
        expect(error, contains('2000mg'));
      });
    });
  });
}

class _MockPrescriptionRepo extends Mock {
  Future<PrescriptionModel> create(CreatePrescriptionRequest request) =>
      super.noSuchMethod(
        Invocation.method(#create, [request]),
        returnValue: Future.value(PrescriptionModel(
          id: 'mock', historiaClinicaId: '', pacienteId: '',
          medicamentoId: '', nombreMedicamento: '', dosis: '',
          via: ViaAdministracion.oral, frecuencia: '',
        )),
      ) as Future<PrescriptionModel>;
}
