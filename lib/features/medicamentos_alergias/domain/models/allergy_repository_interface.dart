import '../models/allergy_model.dart';

/// Contrato del repositorio de alergias.
/// Paulo implementa esto en allergy_repository.dart.
abstract class IAllergyRepository {
  /// PB-20: Registrar nueva alergia
  Future<AllergyModel> createAllergy(CreateAllergyRequest request);

  /// Obtener todas las alergias de un paciente
  Future<List<AllergyModel>> getAllergiesByPatient(String pacienteId);

  /// PB-20 criterio 3: Cambiar estado activa/inactiva (solo médicos)
  Future<AllergyModel> updateAllergyStatus({
    required String allergyId,
    required AllergyStatus newStatus,
  });

  /// PB-20 criterio 4: Buscar medicamentos/agentes para autocompletado
  Future<List<MedicationModel>> searchMedications(String query);
}
