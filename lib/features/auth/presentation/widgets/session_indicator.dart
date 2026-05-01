import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_provider.dart';

/// PB-06 · Widget que muestra en el AppBar cuánto tiempo queda de sesión.
/// Solo se muestra si quedan menos de 10 minutos — aviso sutil al usuario.
///
/// Uso en cualquier pantalla protegida:
/// ```dart
/// AppBar(
///   title: Text('Historia clínica'),
///   actions: [SessionIndicator()],
/// )
/// ```
class SessionIndicator extends ConsumerWidget {
  const SessionIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expiryAsync = ref.watch(tokenExpiryProvider);

    return expiryAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (minutes) {
        // Solo mostrar aviso si quedan menos de 10 minutos
        if (minutes > 10) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Chip(
            avatar: Icon(
              Icons.timer_outlined,
              size: 14,
              color: minutes <= 2
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            label: Text(
              '${minutes}min',
              style: TextStyle(
                fontSize: 11,
                color: minutes <= 2
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            backgroundColor: minutes <= 2
                ? Theme.of(context).colorScheme.errorContainer
                : Theme.of(context).colorScheme.primaryContainer,
            side: BorderSide.none,
            padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}
