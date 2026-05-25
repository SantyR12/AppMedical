import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/allergy_model.dart';
import '../../providers/allergy_provider.dart';

/// PB-22: Banner prominente de alergias activas.
///
/// Se muestra en la parte superior de la historia clínica.
/// - Rojo si hay alergias graves o mortales
/// - Naranja si la más grave es moderada
/// - Amarillo si la más grave es leve
/// - Verde si no hay alergias activas
/// No es colapsable ni descartable.
class AllergyBannerWidget extends ConsumerWidget {
  const AllergyBannerWidget({
    super.key,
    required this.pacienteId,
    required this.onTap,
  });

  final String pacienteId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allergyBannerProvider(pacienteId));

    return state.when(
      loading: () => const _BannerSkeleton(),
      error: (_, __) => const SizedBox.shrink(),
      data: (active) {
        if (active.isEmpty) {
          return _BannerTile(
            bgColor: Colors.green.shade50,
            borderColor: Colors.green.shade400,
            iconColor: Colors.green.shade700,
            textColor: Colors.green.shade900,
            icon: Icons.check_circle_outline,
            text: 'Sin alergias activas registradas',
            onTap: onTap,
          );
        }

        const order = {
          AllergySeverity.mortal: 3,
          AllergySeverity.grave: 2,
          AllergySeverity.moderada: 1,
          AllergySeverity.leve: 0,
        };
        final sorted = List<AllergyModel>.from(active)
          ..sort((a, b) =>
              (order[b.severidad] ?? 0) - (order[a.severidad] ?? 0));

        final worst = sorted.first.severidad;
        late Color bgColor, borderColor, iconColor, textColor;

        if (worst == AllergySeverity.mortal || worst == AllergySeverity.grave) {
          bgColor = Colors.red.shade50;
          borderColor = Colors.red.shade600;
          iconColor = Colors.red.shade800;
          textColor = Colors.red.shade900;
        } else if (worst == AllergySeverity.moderada) {
          bgColor = Colors.orange.shade50;
          borderColor = Colors.orange.shade500;
          iconColor = Colors.orange.shade800;
          textColor = Colors.orange.shade900;
        } else {
          bgColor = Colors.amber.shade50;
          borderColor = Colors.amber.shade500;
          iconColor = Colors.amber.shade800;
          textColor = Colors.amber.shade900;
        }

        final shown = sorted.take(3).map((a) => a.agenteCausante).join(', ');
        final extra = active.length > 3 ? ' (+${active.length - 3} más)' : '';
        final label =
            '${active.length} ${active.length == 1 ? 'alergia activa' : 'alergias activas'}: $shown$extra';

        return _BannerTile(
          bgColor: bgColor,
          borderColor: borderColor,
          iconColor: iconColor,
          textColor: textColor,
          icon: Icons.warning_rounded,
          text: label,
          onTap: onTap,
        );
      },
    );
  }
}

class _BannerTile extends StatelessWidget {
  const _BannerTile({
    required this.bgColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Color bgColor, borderColor, iconColor, textColor;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: iconColor, size: 18),
          ],
        ),
      ),
    );
  }
}

class _BannerSkeleton extends StatelessWidget {
  const _BannerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
