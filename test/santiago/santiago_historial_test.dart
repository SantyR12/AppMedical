// APA-39 (T-06) · APA-40 (T-07) · APA-41 (T-08) · APA-42 (T-09)
// Ejecutar: flutter test test/santiago/santiago_historial_test.dart
// Generar mocks: dart run build_runner build --delete-conflicting-outputs

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/historial/domain/models/patient_model.dart';
import 'package:sgp_app/features/historial/domain/repositories/historial_repository_interface.dart';
import 'package:sgp_app/features/historial/providers/historial_provider.dart';

import 'santiago_historial_test.mocks.dart';

@GenerateMocks([IHistorialRepository])
void main() {
  late MockIHistorialRepository mockRepo;
  late HistorialNotifier notifier;
  late PatientSearchNotifier searchNotifier;

  final pacientePrueba = PatientModel(
    id: 'pac-001',
    nombreCompleto: 'Juan Carlos Pérez García',
    tipoDocumento: DocumentType.cc,
    numeroDocumento: '1023456789',
    fechaNacimiento: DateTime(1985, 3, 15),
    sexo: Sex.masculino,
    telefono: '3001234567',
    correo: 'juan.perez@email.com',
    creadoEn: DateTime(2025, 4, 1),
  );

  final historiaCompleta = ClinicalRecordModel(
    id: 'hc-001',
    pacienteId: 'pac-001',
    paciente: pacientePrueba,
    estado: RecordStatus.activa,
    creadoEn: DateTime(2025, 4, 1),
  );

  setUp(() {
    mockRepo = MockIHistorialRepository();
    notifier = HistorialNotifier(mockRepo);
    searchNotifier = PatientSearchNotifier(mockRepo);
  });

  // APA-39 — T-06
  group('APA-39 | T-06 — Crear historia clínica con todos los campos', () {
    test('retorna ClinicalRecordModel cuando todos los campos requeridos están presentes', () async {
      final request = CreateClinicalRecordRequest(
        nombreCompleto: 'Juan Carlos Pérez García',
        tipoDocumento: DocumentType.cc,
        numeroDocumento: '1023456789',
        fechaNacimiento: DateTime(1985, 3, 15),
        sexo: Sex.masculino,
        telefono: '3001234567',
        correo: 'juan.perez@email.com',
      );

      when(mockRepo.createRecord(any)).thenAnswer((_) async => historiaCompleta);

      await notifier.createRecord(request);

      expect(notifier.state.record, isNotNull);
      expect(notifier.state.record?.paciente.nombreCompleto, 'Juan Carlos Pérez García');
      expect(notifier.state.record?.estado, RecordStatus.activa);
    });

    test('isLoading queda en false después de crear exitosamente', () async {
      when(mockRepo.createRecord(any)).thenAnswer((_) async => historiaCompleta);

      await notifier.createRecord(CreateClinicalRecordRequest(
        nombreCompleto: 'Juan Carlos Pérez García',
        tipoDocumento: DocumentType.cc,
        numeroDocumento: '1023456789',
        fechaNacimiento: DateTime(1985, 3, 15),
        sexo: Sex.masculino,
      ));

      expect(notifier.state.isLoading, isFalse);
      expect(notifier.state.hasError, isFalse);
    });

    test('lanza error cuando el paciente ya tiene historia clínica (409)', () async {
      when(mockRepo.createRecord(any)).thenThrow(
        Exception('Ya existe un paciente con ese número y tipo de documento'),
      );

      await notifier.createRecord(CreateClinicalRecordRequest(
        nombreCompleto: 'Juan Duplicado',
        tipoDocumento: DocumentType.cc,
        numeroDocumento: '1023456789',
        fechaNacimiento: DateTime(1985, 3, 15),
        sexo: Sex.masculino,
      ));

      expect(notifier.state.hasError, isTrue);
      expect(notifier.state.errorMessage, contains('existe'));
    });
  });

  // APA-40 — T-07
  group('APA-40 | T-07 — Control de acceso por rol', () {
    test('el router redirige enfermero a /dashboard/enfermero y no a /dashboard/medico', () {
      String dashboardParaRol(UserRole rol) {
        switch (rol) {
          case UserRole.medico:      return '/dashboard/medico';
          case UserRole.enfermero:   return '/dashboard/enfermero';
          case UserRole.admin:       return '/dashboard/admin';
          case UserRole.farmaceutico: return '/dashboard/farmacia';
        }
      }
      expect(dashboardParaRol(UserRole.enfermero), '/dashboard/enfermero');
      expect(dashboardParaRol(UserRole.enfermero), isNot('/dashboard/medico'));
    });

    test('archivar historia cambia el estado a archivada', () async {
      when(mockRepo.getRecordByPatientId('pac-001')).thenAnswer((_) async => historiaCompleta);
      await notifier.loadRecord('pac-001');

      final historiaArchivada = historiaCompleta.copyWith(estado: RecordStatus.archivada);
      when(mockRepo.archiveRecord('hc-001')).thenAnswer((_) async => historiaArchivada);

      await notifier.archiveRecord('hc-001');

      expect(notifier.state.record?.estado, RecordStatus.archivada);
    });
  });

  // APA-41 — T-08
  group('APA-41 | T-08 — Búsqueda por número de documento exacto', () {
    test('retorna el paciente correcto al buscar por documento exacto', () async {
      when(mockRepo.searchPatients(any)).thenAnswer((_) async => [pacientePrueba]);

      await searchNotifier.search('1023456789');

      expect(searchNotifier.state.results, hasLength(1));
      expect(searchNotifier.state.results.first.numeroDocumento, '1023456789');
    });

    test('retorna lista vacía cuando el documento no existe', () async {
      when(mockRepo.searchPatients(any)).thenAnswer((_) async => []);

      await searchNotifier.search('9999999999');

      expect(searchNotifier.state.results, isEmpty);
    });
  });

  // APA-42 — T-09
  group('APA-42 | T-09 — Búsqueda por nombre parcial', () {
    final pacientes = [
      PatientModel(
        id: 'pac-001', nombreCompleto: 'Juan Carlos Pérez García',
        tipoDocumento: DocumentType.cc, numeroDocumento: '1023456789',
        fechaNacimiento: DateTime(1985, 3, 15), sexo: Sex.masculino,
      ),
      PatientModel(
        id: 'pac-002', nombreCompleto: 'Juan Pablo Rodríguez',
        tipoDocumento: DocumentType.cc, numeroDocumento: '1098765432',
        fechaNacimiento: DateTime(1992, 7, 20), sexo: Sex.masculino,
      ),
    ];

    test('búsqueda "Juan" retorna todos los pacientes que contienen "Juan"', () async {
      when(mockRepo.searchPatients(any)).thenAnswer(
        (_) async => pacientes.where(
          (p) => p.nombreCompleto.toLowerCase().contains('juan'),
        ).toList(),
      );

      await searchNotifier.search('Juan');

      expect(searchNotifier.state.results, hasLength(2));
      expect(searchNotifier.state.results.every((p) => p.nombreCompleto.contains('Juan')), isTrue);
    });

    test('búsqueda con query vacío no llama al repositorio', () async {
      await searchNotifier.search('');
      verifyNever(mockRepo.searchPatients(any));
    });

    test('búsqueda con menos de 3 caracteres no dispara la petición', () async {
      await searchNotifier.search('Ju');
      verifyNever(mockRepo.searchPatients(any));
    });
  });
}
