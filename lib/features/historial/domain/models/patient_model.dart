import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

/// Tipos de documento colombianos (PB-10 criterio 1)
enum DocumentType {
  @JsonValue('CC') cc,   // Cédula de ciudadanía
  @JsonValue('TI') ti,   // Tarjeta de identidad
  @JsonValue('CE') ce,   // Cédula de extranjería
  @JsonValue('PAS') pas, // Pasaporte
}

enum Sex {
  @JsonValue('M') masculino,
  @JsonValue('F') femenino,
  @JsonValue('O') otro,
}

/// Contacto de emergencia — campos opcionales (PB-10 criterio 2)
@freezed
abstract class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    String? nombre,
    String? telefono,
  }) = _EmergencyContact;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);
}

/// Modelo de paciente — datos demográficos completos (PB-10)
///
/// Generar archivos con:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
abstract class PatientModel with _$PatientModel {
  const factory PatientModel({
    required String id,
    required String nombreCompleto,
    required DocumentType tipoDocumento,
    required String numeroDocumento,
    required DateTime fechaNacimiento,
    required Sex sexo,
    String? direccion,
    String? telefono,
    String? correo,
    EmergencyContact? contactoEmergencia,
    // Relación con la historia clínica
    String? historiaClinicaId,
    DateTime? creadoEn,
    String? ultimoMedicoTratante,
  }) = _PatientModel;

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}

/// Estados de la historia clínica (PB-09 criterio 5)
/// No se puede eliminar, solo archivar
enum RecordStatus {
  @JsonValue('activa') activa,
  @JsonValue('archivada') archivada,
}

/// Historia clínica completa (PB-09)
@freezed
abstract class ClinicalRecordModel with _$ClinicalRecordModel {
  const factory ClinicalRecordModel({
    required String id,
    required String pacienteId,
    required PatientModel paciente,
    @Default(RecordStatus.activa) RecordStatus estado,
    // Listas de los otros módulos — llegan como referencias
    @Default([]) List<String> alergiasIds,
    @Default([]) List<String> medicamentosActivosIds,
    @Default([]) List<String> diagnosticosIds,
    @Default([]) List<String> consultasPreviasIds,
    // Log de auditoría — quién editó y cuándo (PB-09 criterio 2)
    String? ultimoEditadoPor,
    String? ultimoEditadoDesde,
    DateTime? ultimaEdicionEn,
    DateTime? creadoEn,
  }) = _ClinicalRecordModel;

  factory ClinicalRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicalRecordModelFromJson(json);
}

/// Request para crear nueva historia clínica (PB-09 criterio 1)
@freezed
abstract class CreateClinicalRecordRequest with _$CreateClinicalRecordRequest {
  const factory CreateClinicalRecordRequest({
    required String nombreCompleto,
    required DocumentType tipoDocumento,
    required String numeroDocumento,
    required DateTime fechaNacimiento,
    required Sex sexo,
    String? direccion,
    String? telefono,
    String? correo,
    EmergencyContact? contactoEmergencia,
  }) = _CreateClinicalRecordRequest;

  factory CreateClinicalRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClinicalRecordRequestFromJson(json);
}

/// Parámetros de búsqueda de pacientes (PB-14)
@freezed
abstract class PatientSearchParams with _$PatientSearchParams {
  const factory PatientSearchParams({
    String? nombre,
    String? numeroDocumento,
    DateTime? fechaNacimiento,
  }) = _PatientSearchParams;

  factory PatientSearchParams.fromJson(Map<String, dynamic> json) =>
      _$PatientSearchParamsFromJson(json);
}