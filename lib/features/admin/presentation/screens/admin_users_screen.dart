import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sgp_app/core/router.dart';
import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/auth/providers/auth_provider.dart';
import 'package:sgp_app/features/auth/data/repositories/auth_repository.dart';

class AdminUsersScreen extends ConsumerStatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  UserRole? _filterRol;

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            tooltip: 'Crear usuario',
            onPressed: () => context.push(AppRoutes.adminCreateUser),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualizar',
            onPressed: () => ref.invalidate(usersListProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          _RoleFilterBar(
            selected: _filterRol,
            onSelected: (rol) => setState(() => _filterRol = rol),
          ),
          Expanded(
            child: usersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48,
                        color: Theme.of(context).colorScheme.error),
                    const SizedBox(height: 12),
                    Text(
                      e.toString().replaceFirst('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => ref.invalidate(usersListProvider),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
              data: (users) {
                final filtered = _filterRol == null
                    ? users
                    : users.where((u) => u.rol == _filterRol).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group_outlined,
                            size: 56,
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        const SizedBox(height: 16),
                        const Text('No hay usuarios en esta categoría'),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, i) =>
                      _UserCard(user: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filtro de roles ──────────────────────────────────────────────────────────

class _RoleFilterBar extends StatelessWidget {
  const _RoleFilterBar({required this.selected, required this.onSelected});

  final UserRole? selected;
  final ValueChanged<UserRole?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Todos'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          const SizedBox(width: 8),
          ...UserRole.values.map(
            (rol) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_rolLabel(rol)),
                selected: selected == rol,
                onSelected: (_) =>
                    onSelected(selected == rol ? null : rol),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _rolLabel(UserRole rol) {
    switch (rol) {
      case UserRole.admin:        return 'Admins';
      case UserRole.medico:       return 'Médicos';
      case UserRole.enfermero:    return 'Enfermeros';
      case UserRole.farmaceutico: return 'Farmacéuticos';
    }
  }
}

// ── Tarjeta de usuario ───────────────────────────────────────────────────────

class _UserCard extends ConsumerWidget {
  const _UserCard({required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolColor = _rolColor(user.rol);
    final statusColor = user.estado == AccountStatus.activo
        ? Colors.green
        : user.estado == AccountStatus.bloqueado
            ? Colors.red
            : Colors.orange;

    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: rolColor.withValues(alpha: 0.15),
          child: Text(
            user.nombre.isNotEmpty ? user.nombre[0].toUpperCase() : '?',
            style: TextStyle(
                color: rolColor, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          user.nombre,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              user.correo,
              style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _Badge(
                  label: _rolLabel(user.rol),
                  color: rolColor,
                ),
                const SizedBox(width: 6),
                _Badge(
                  label: _estadoLabel(user.estado),
                  color: statusColor,
                ),
              ],
            ),
          ],
        ),
        // PB-05: botón de desbloqueo para usuarios bloqueados
        trailing: user.estado == AccountStatus.bloqueado
            ? IconButton(
                icon: const Icon(Icons.lock_open_outlined),
                tooltip: 'Desbloquear cuenta',
                color: Colors.red,
                onPressed: () => _confirmUnblock(context, ref),
              )
            : null,
      ),
    );
  }

  Future<void> _confirmUnblock(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Desbloquear cuenta'),
        content: Text(
          '¿Deseas desbloquear la cuenta de ${user.nombre}? '
          'El usuario podrá iniciar sesión de nuevo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Desbloquear'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(authRepositoryProvider).unblockUser(user.id);
      ref.invalidate(usersListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cuenta de ${user.nombre} desbloqueada'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Color _rolColor(UserRole rol) {
    switch (rol) {
      case UserRole.admin:        return Colors.indigo;
      case UserRole.medico:       return Colors.blue;
      case UserRole.enfermero:    return Colors.teal;
      case UserRole.farmaceutico: return Colors.purple;
    }
  }

  String _rolLabel(UserRole rol) {
    switch (rol) {
      case UserRole.admin:        return 'Admin';
      case UserRole.medico:       return 'Médico';
      case UserRole.enfermero:    return 'Enfermero/a';
      case UserRole.farmaceutico: return 'Farmacéutico/a';
    }
  }

  String _estadoLabel(AccountStatus estado) {
    switch (estado) {
      case AccountStatus.activo:    return 'Activo';
      case AccountStatus.pendiente: return 'Pendiente';
      case AccountStatus.bloqueado: return 'Bloqueado';
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
