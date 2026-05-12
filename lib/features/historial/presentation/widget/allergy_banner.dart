import 'package:flutter/material.dart';

/// PB-22: Banner prominente de alergias activas en el perfil del paciente.
///
/// Muestra un banner rojo si hay alergias graves o mortales,
/// naranja si hay alergias activas sin severidad crítica.
/// No ocupa espacio si el paciente no tiene alergias activas.
class AllergyBanner extends StatelessWidget {
  const AllergyBanner({
    super.key,
    required this.allergyCount,
    required this.hasSevere,
    required this.allergenNames,
    this.onTap,
  });

  /// Número total de alergias activas del paciente.
  final int allergyCount;

  /// true si hay al menos una alergia con severidad 'grave' o 'mortal'.
  final bool hasSevere;

  /// Lista de nombres de los alérgenos activos (máximo 2 se muestran).
  final List<String> allergenNames;

  /// Callback al tocar el banner — normalmente navega a la lista completa.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (allergyCount == 0) return const SizedBox.shrink();

    final bgColor     = hasSevere ? Colors.red.shade50     : Colors.orange.shade50;
    final borderColor = hasSevere ? Colors.red.shade400    : Colors.orange.shade400;
    final iconColor   = hasSevere ? Colors.red.shade700    : Colors.orange.shade700;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(Icons.warning_rounded, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasSevere
                        ? 'ALERGIA GRAVE — $allergyCount alergia(s) registrada(s)'
                        : '$allergyCount alergia(s) activa(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: iconColor,
                    ),
                  ),
                  if (allergenNames.isNotEmpty)
                    Text(
                      allergenNames.join(' · '),
                      style: TextStyle(fontSize: 12, color: iconColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: iconColor, size: 18),
          ],
        ),
      ),
    );
  }
}
