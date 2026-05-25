import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme.dart';
import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/sgp_text_field.dart';
import '../../providers/auth_provider.dart';

/// PB-03: Login con correo y contraseña.
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

  bool _esBloqueada(String? msg) =>
      msg != null && msg.toLowerCase().contains('bloqueada');

  Future<void> _submit() async {
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: SgpColors.background,
      body: Stack(
        children: [
          // ── Cabecera degradada azul ──────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.42,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D47A1),
                    Color(0xFF1565C0),
                    Color(0xFF1976D2),
                  ],
                ),
              ),
            ),
          ),

          // ── Patrón decorativo ────────────────────────────────────────────
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),

          // ── Contenido principal ──────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 48),

                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.local_hospital_rounded,
                      color: SgpColors.primary,
                      size: 44,
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'SGP',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sistema de Gestión de Pacientes',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Tarjeta del formulario ─────────────────────────────
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: SgpColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Ingresa tus credenciales para continuar',
                            style: TextStyle(
                              fontSize: 13,
                              color: SgpColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 24),

                          SgpTextField(
                            label: 'Correo electrónico',
                            hint: 'nombre@dominio.com',
                            controller: _correoController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_outlined),
                            validator: SgpValidators.email,
                            autofillHints: const [AutofillHints.email],
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_contrasenaFocus);
                            },
                          ),
                          const FormGap(height: 14),

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
                          const SizedBox(height: 20),

                          if (actionState.isError) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: SgpColors.error.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:
                                        SgpColors.error.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline,
                                      color: SgpColors.error, size: 18),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      actionState.errorMessage!,
                                      style: const TextStyle(
                                        color: SgpColors.error,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: actionState.isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: actionState.isLoading
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Ingresar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Versión / footer
                  Text(
                    'v1.0.0 · Uso exclusivo del personal autorizado',
                    style: TextStyle(
                      fontSize: 11,
                      color: SgpColors.textHint,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
