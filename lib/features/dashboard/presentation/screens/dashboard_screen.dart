import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sgp_app/core/router.dart';
import 'package:sgp_app/core/theme.dart';
import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/auth/providers/auth_provider.dart';
import 'package:sgp_app/features/auth/presentation/widgets/session_indicator.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).state.user;

    return Scaffold(
      backgroundColor: SgpColors.background,
      body: CustomScrollView(
        slivers: [
          // ── AppBar expandible con degradado ─────────────────────────────
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            backgroundColor: SgpColors.primary,
            actionsIconTheme: const IconThemeData(color: Colors.white),
            actions: [
              const SessionIndicator(),
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                tooltip: 'Cerrar sesión',
                onPressed: () =>
                    ref.read(authStateProvider.notifier).logout(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _DashboardHeader(user: user),
            ),
          ),

          // ── Cuerpo ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionLabel('Accesos rápidos'),
                      const SizedBox(height: 14),
                      _MenuGrid(rol: user?.rol),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Cabecera del dashboard ────────────────────────────────────────────────────

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.user});
  final UserModel? user;

  String _rolLabel(UserRole? rol) {
    switch (rol) {
      case UserRole.admin:        return 'Administrador del sistema';
      case UserRole.medico:       return 'Médico tratante';
      case UserRole.enfermero:    return 'Personal de enfermería';
      case UserRole.farmaceutico: return 'Farmacéutico';
      default:                    return 'Usuario';
    }
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos días';
    if (h < 18) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2)],
        ),
      ),
      child: Stack(
        children: [
          // Círculos decorativos
          Positioned(
            top: -20,
            right: -20,
            child: _DecorCircle(size: 160, opacity: 0.06),
          ),
          Positioned(
            bottom: 10,
            right: 60,
            child: _DecorCircle(size: 90, opacity: 0.07),
          ),

          // Contenido
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: Center(
                    child: Text(
                      (user?.nombre.isNotEmpty == true)
                          ? user!.nombre[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_greeting()},',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.nombre ?? 'Usuario',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _rolLabel(user?.rol),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorCircle extends StatelessWidget {
  const _DecorCircle({required this.size, required this.opacity});
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: opacity),
        ),
      );
}

// ── Label de sección ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: SgpColors.textSecondary,
          letterSpacing: 0.6,
        ),
      );
}

// ── Grid de menú ─────────────────────────────────────────────────────────────

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({required this.rol});
  final UserRole? rol;

  @override
  Widget build(BuildContext context) {
    final items = _itemsForRol(rol);
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth < 400 ? 1 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.1,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) => _MenuCard(item: items[i]),
        );
      },
    );
  }

  List<_MenuItem> _itemsForRol(UserRole? rol) {
    switch (rol) {
      case UserRole.admin:
        return [
          _MenuItem(
            title: 'Usuarios',
            subtitle: 'Gestionar cuentas',
            icon: Icons.group_outlined,
            gradient: const [Color(0xFF3949AB), Color(0xFF5C6BC0)],
            route: AppRoutes.adminUsers,
          ),
          _MenuItem(
            title: 'Crear Usuario',
            subtitle: 'Nuevo miembro',
            icon: Icons.person_add_outlined,
            gradient: const [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
            route: AppRoutes.adminCreateUser,
          ),
          _MenuItem(
            title: 'Pacientes',
            subtitle: 'Buscar historia',
            icon: Icons.search_outlined,
            gradient: const [Color(0xFF0277BD), Color(0xFF039BE5)],
            route: AppRoutes.patients,
          ),
          _MenuItem(
            title: 'Nuevo Paciente',
            subtitle: 'Registrar',
            icon: Icons.person_add_alt_1_outlined,
            gradient: const [Color(0xFF2E7D32), Color(0xFF43A047)],
            route: AppRoutes.newPatient,
          ),
        ];
      case UserRole.medico:
        return [
          _MenuItem(
            title: 'Buscar Paciente',
            subtitle: 'Ver historia clínica',
            icon: Icons.search_outlined,
            gradient: const [Color(0xFF0277BD), Color(0xFF039BE5)],
            route: AppRoutes.patients,
          ),
          _MenuItem(
            title: 'Nuevo Paciente',
            subtitle: 'Registrar',
            icon: Icons.person_add_alt_1_outlined,
            gradient: const [Color(0xFF2E7D32), Color(0xFF43A047)],
            route: AppRoutes.newPatient,
          ),
        ];
      case UserRole.enfermero:
        return [
          _MenuItem(
            title: 'Buscar Paciente',
            subtitle: 'Consultar registros',
            icon: Icons.search_outlined,
            gradient: const [Color(0xFF00695C), Color(0xFF00897B)],
            route: AppRoutes.patients,
          ),
        ];
      case UserRole.farmaceutico:
        return [
          _MenuItem(
            title: 'Buscar Paciente',
            subtitle: 'Prescripciones',
            icon: Icons.search_outlined,
            gradient: const [Color(0xFF6A1B9A), Color(0xFF7B1FA2)],
            route: AppRoutes.patients,
          ),
        ];
      default:
        return [
          _MenuItem(
            title: 'Buscar Paciente',
            subtitle: '',
            icon: Icons.search_outlined,
            gradient: const [Color(0xFF0277BD), Color(0xFF039BE5)],
            route: AppRoutes.patients,
          ),
        ];
    }
  }
}

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.route,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String route;
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.item});
  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(item.route),
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: item.gradient,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: item.gradient.last.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 26),
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (item.subtitle.isNotEmpty)
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
