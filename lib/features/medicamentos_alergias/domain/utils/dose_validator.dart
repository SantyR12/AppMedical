// PB-18: Validador de dosis máxima por peso — clase Dart pura (sin Flutter)
// Fácil de testear sin emulador ni widgets
class DoseValidator {
  // Dosis máxima diaria en mg/kg para medicamentos catalogados
  static const _maxDoseMgPerKg = {
    'ibuprofeno':   40.0,
    'paracetamol':  75.0,
    'amoxicilina':  90.0,
    'ampicilina':   200.0,
    'enalapril':    0.6,
    'atenolol':     2.0,
    'omeprazol':    1.0,
    'loratadina':   0.25,
    'cetirizina':   0.25,
    'metformina':   2000.0, // mg/día absoluto
  };

  /// Retorna mensaje de error si supera la dosis máxima, null si es válido.
  /// Si el medicamento no está catalogado retorna null (no bloquear al médico).
  static String? validate({
    required double dosisMg,
    required double pesoKg,
    required String nombreGenerico,
  }) {
    final key = nombreGenerico.toLowerCase().trim();
    final maxPorKg = _maxDoseMgPerKg[key];
    if (maxPorKg == null) return null;

    final maxDosis = maxPorKg * pesoKg;
    if (dosisMg > maxDosis) {
      return 'Dosis excede el máximo recomendado '
          '(${maxDosis.toStringAsFixed(0)}mg para ${pesoKg}kg)';
    }
    return null;
  }
}