/// Validaciones de formulario usadas en todo el SGP.
/// Funciones puras — sin estado, sin dependencias de Flutter.
class SgpValidators {
  SgpValidators._();

  /// Valida formato de correo (PB-01 criterio 2)
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo es obligatorio';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Ingresa un correo válido (nombre@dominio.com)';
    }
    return null;
  }

  /// Valida contraseña mínimo 8 caracteres (PB-01 criterio 2)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }
    return null;
  }

  /// Campo requerido genérico
  static String? required(String? value, {String fieldName = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  /// Nombre completo — mínimo 2 palabras
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre completo es obligatorio';
    }
    final parts = value.trim().split(' ').where((p) => p.isNotEmpty);
    if (parts.length < 2) {
      return 'Ingresa el nombre y apellido';
    }
    return null;
  }

  /// OTP de 6 dígitos (PB-04)
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa el código';
    }
    if (value.length != 6 || int.tryParse(value) == null) {
      return 'El código debe ser de 6 dígitos';
    }
    return null;
  }
}
