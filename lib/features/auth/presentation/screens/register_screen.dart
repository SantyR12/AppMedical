import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/sgp_text_field.dart';
import '../../domain/models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../../../core/router.dart';

/// PB-01: Pantalla de registro de usuarios — solo para administradores.
///
/// Criterios implementados:
/// 1. Campos: nombre completo, correo, contraseña temporal, rol
/// 2. Validación de formato de correo y contraseña mínimo 8 chars
/// 3. El usuario queda en estado 'pendiente' (lo maneja el backend)
/// 4. No permite correos duplicados (manejo de error 409)
/// 5. El log de auditoría lo registra el backend automáticamente
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  UserRole _rolSeleccionado = UserRole.medico;

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final request = CreateUserRequest(
      nombre: _nombreController.text.trim(),
      correo: _correoController.text.trim().toLowerCase(),
      contrasenaTemp: _contrasenaController.text,
      rol: _rolSeleccionado,
    );

    await ref.read(registerActionProvider.notifier).createUser(request);

    final actionState = ref.read(registerActionProvider);
    if (actionState.isSuccess && mounted) {
      // Mostrar confirmación y navegar a pantalla de verificación email (PB-02)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usuario creado. Se envió correo de verificación a ${_correoController.text.trim()}',
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      context.go(
        '${AppRoutes.verifyEmail}?email=${Uri.encodeComponent(_correoController.text.trim())}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(registerActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar nuevo usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado
                Text(
                  'Datos del nuevo usuario',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Solo los administradores pueden crear usuarios. El sistema enviará un correo de verificación automáticamente.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 28),

                // Nombre completo
                SgpTextField(
                  label: 'Nombre completo',
                  hint: 'Ej: María García López',
                  controller: _nombreController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: SgpValidators.fullName,
                  autofillHints: const [AutofillHints.name],
                ),
                const FormGap(),

                // Correo electrónico
                SgpTextField(
                  label: 'Correo electrónico',
                  hint: 'nombre@dominio.com',
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: SgpValidators.email,
                  autofillHints: const [AutofillHints.email],
                ),
                const FormGap(),

                // Contraseña temporal
                SgpTextField(
                  label: 'Contraseña temporal',
                  hint: 'Mínimo 8 caracteres',
                  controller: _contrasenaController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: SgpValidators.password,
                  autofillHints: const [AutofillHints.newPassword],
                ),
                const FormGap(height: 20),

                // Selector de rol (PB-01 criterio 1)
                Text(
                  'Rol del usuario',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                _RolSelector(
                  rolSeleccionado: _rolSeleccionado,
                  onRolChanged: (rol) => setState(() => _rolSeleccionado = rol),
                ),
                const SizedBox(height: 28),

                // Mensaje de error del servidor
                if (actionState.isError) ...[
                  FormErrorMessage(message: actionState.errorMessage!),
                  const FormGap(),
                ],

                // Botón registrar
                ElevatedButton(
                  onPressed: actionState.isLoading ? null : _submit,
                  child: actionState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Crear usuario'),
                ),
                const FormGap(),

                // Cancelar
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget de selección de rol con chips visuales
class _RolSelector extends StatelessWidget {
  const _RolSelector({
    required this.rolSeleccionado,
    required this.onRolChanged,
  });

  final UserRole rolSeleccionado;
  final void Function(UserRole) onRolChanged;

  static const _roles = [
    (rol: UserRole.medico, label: 'Médico', icon: Icons.medical_services_outlined),
    (rol: UserRole.enfermero, label: 'Enfermero/a', icon: Icons.healing_outlined),
    (rol: UserRole.admin, label: 'Administrador', icon: Icons.admin_panel_settings_outlined),
    (rol: UserRole.farmaceutico, label: 'Farmacéutico', icon: Icons.medication_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _roles.map((r) {
        final isSelected = rolSeleccionado == r.rol;
        return ChoiceChip(
          label: Text(r.label),
          avatar: Icon(
            r.icon,
            size: 16,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
          ),
          selected: isSelected,
          onSelected: (_) => onRolChanged(r.rol),
          selectedColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}
