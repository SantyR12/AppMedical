import '../models/patient_model.dart';

/// Contrato del repositorio de historial clínico.
/// Santiago implementa esto en historial_repository.dart.
/// Las pantallas y providers solo dependen de esta interfaz.
abstract class IHistorialRepository {
  /// PB-09: Crear nueva historia clínica desde "Nuevo Paciente"
  Future<ClinicalRecordModel> createRecord(
      CreateClinicalRecordRequest request);

  /// PB-09: Obtener historia clínica por ID de paciente
  Future<ClinicalRecordModel> getRecordByPatientId(String pacienteId);

  /// PB-09: Actualizar historia clínica (registra auditoría automáticamente)
  Future<ClinicalRecordModel> updateRecord({
    required String recordId,
    required CreateClinicalRecordRequest data,
  });

  /// PB-09 criterio 5: Archivar historia (nunca eliminar)
  Future<ClinicalRecordModel> archiveRecord(String recordId);

  /// PB-14: Buscar pacientes por nombre, documento o fecha de nacimiento
  Future<List<PatientModel>> searchPatients(PatientSearchParams params);
}