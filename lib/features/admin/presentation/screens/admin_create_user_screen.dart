import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sgp_app/features/auth/domain/models/user_model.dart';
import 'package:sgp_app/features/auth/providers/auth_provider.dart';

class AdminCreateUserScreen extends ConsumerStatefulWidget {
  const AdminCreateUserScreen({super.key});

  @override
  ConsumerState<AdminCreateUserScreen> createState() =>
      _AdminCreateUserScreenState();
}

class _AdminCreateUserScreenState
    extends ConsumerState<AdminCreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  UserRole _rol = UserRole.medico;
  bool _passVisible = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(registerActionProvider.notifier).createUser(
          CreateUserRequest(
            nombre: _nombreCtrl.text.trim(),
            correo: _correoCtrl.text.trim(),
            contrasenaTemp: _passCtrl.text,
            rol: _rol,
          ),
        );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nombreCtrl.clear();
    _correoCtrl.clear();
    _passCtrl.clear();
    setState(() => _rol = UserRole.medico);
    ref.read(registerActionProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerActionProvider);

    ref.listen(registerActionProvider, (_, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario creado exitosamente')),
        );
        _resetForm();
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? 'Error al crear usuario'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        ref.read(registerActionProvider.notifier).reset();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Nombre ──────────────────────────────────────────────
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),

              // ── Correo ──────────────────────────────────────────────
              TextFormField(
                controller: _correoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo requerido';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                    return 'Correo inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Contraseña temporal ─────────────────────────────────
              TextFormField(
                controller: _passCtrl,
                obscureText: !_passVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña temporal',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  helperText: 'Mínimo 8 caracteres. El usuario deberá cambiarla al iniciar sesión.',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _passVisible = !_passVisible),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (v.length < 8) return 'Mínimo 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Rol ─────────────────────────────────────────────────
              DropdownButtonFormField<UserRole>(
                value: _rol,
                decoration: const InputDecoration(
                  labelText: 'Rol',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                items: const [
                  DropdownMenuItem(
                    value: UserRole.medico,
                    child: Text('Médico'),
                  ),
                  DropdownMenuItem(
                    value: UserRole.enfermero,
                    child: Text('Enfermero/a'),
                  ),
                  DropdownMenuItem(
                    value: UserRole.admin,
                    child: Text('Administrador'),
                  ),
                  DropdownMenuItem(
                    value: UserRole.farmaceutico,
                    child: Text('Farmacéutico/a'),
                  ),
                ],
                onChanged: (v) => setState(() => _rol = v!),
              ),
              const SizedBox(height: 32),

              // ── Botón ───────────────────────────────────────────────
              ElevatedButton.icon(
                onPressed: state.isLoading ? null : _submit,
                icon: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.person_add_outlined),
                label: Text(state.isLoading ? 'Creando...' : 'Crear usuario'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
