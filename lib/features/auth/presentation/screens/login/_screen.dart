import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router.dart';
import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/sgp_text_field.dart';
import '../../providers/auth_provider.dart';

/// PB-03: Pantalla de login con correo y contraseña.
///
/// Criterios implementados:
/// 1. Dos campos: correo y contraseña
/// 2. Redirige al flujo MFA si las credenciales son correctas (→ MfaScreen)
/// 3. Mensaje genérico de error (sin revelar cuál campo falló)
/// 4. Ícono de ojo para mostrar/ocultar contraseña (en SgpTextField)
/// 5. Funciona en Android 8+ e iOS 13+ (garantizado por Flutter SDK)
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _contrasenaFocus = FocusNode();

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    _contrasenaFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Ocultar teclado
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    await ref.read(loginActionProvider.notifier).login(
          correo: _correoController.text.trim().toLowerCase(),
          contrasena: _contrasenaController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(loginActionProvider);

    // Cuando el login es exitoso, go_router redirige automáticamente
    // porque authStateProvider notifica el cambio al router.
    // No necesitamos navegar manualmente aquí.

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),

                // Logo / encabezado
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.local_hospital_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                Center(
                  child: Text(
                    'SGP',
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    'Sistema de Gestión de Pacientes',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),
                ),
                const SizedBox(height: 48),

                Text(
                  'Iniciar sesión',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 20),

                // Formulario
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo correo
                      SgpTextField(
                        label: 'Correo electrónico',
                        hint: 'nombre@dominio.com',
                        controller: _correoController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: SgpValidators.email,
                        autofillHints: const [AutofillHints.email],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_contrasenaFocus);
                        },
                      ),
                      const FormGap(height: 16),

                      // Campo contraseña con ícono de ojo (PB-03 criterio 4)
                      SgpTextField(
                        label: 'Contraseña',
                        controller: _contrasenaController,
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        focusNode: _contrasenaFocus,
                        validator: (v) => v == null || v.isEmpty
                            ? 'La contraseña es obligatoria'
                            : null,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      const FormGap(height: 24),

                      // Mensaje de error genérico (PB-03 criterio 3)
                      // "Correo o contraseña incorrectos" — sin especificar cuál
                      if (actionState.isError) ...[
                        FormErrorMessage(message: actionState.errorMessage!),
                        const FormGap(height: 16),
                      ],

                      // Botón ingresar
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
                            : const Text('Ingresar'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Separador
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: Theme.of(context).colorScheme.outlineVariant)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Administradores',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                            color: Theme.of(context).colorScheme.outlineVariant)),
                  ],
                ),
                const SizedBox(height: 16),

                // Enlace a registro de nuevo usuario
                Center(
                  child: TextButton.icon(
                    icon: const Icon(Icons.person_add_outlined, size: 18),
                    label: const Text('Registrar nuevo usuario'),
                    onPressed: () => context.go(AppRoutes.register),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
