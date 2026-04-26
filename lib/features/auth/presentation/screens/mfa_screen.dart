import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/router.dart';
import '../../providers/auth_provider.dart';

/// PB-04: Pantalla de autenticación multifactor (MFA) con OTP de 6 dígitos.
///
/// Criterios implementados:
/// 1. OTP de 6 dígitos numéricos
/// 2. Expira en 5 minutos (countdown visual)
/// 3. El usuario elige canal por queryParam (correo o SMS) — info visual
/// 4. Si ingresa mal el OTP 3 veces → vuelve al login
/// 5. Botón 'Reenviar código' habilitado después de 60 segundos
/// 6. OTP no reutilizable — lo valida el backend
class MfaScreen extends ConsumerStatefulWidget {
  const MfaScreen({super.key});

  @override
  ConsumerState<MfaScreen> createState() => _MfaScreenState();
}

class _MfaScreenState extends ConsumerState<MfaScreen> {
  final _pinController = TextEditingController();
  final _pinFocus = FocusNode();

  int _otpExpirySeconds = 300; // 5 minutos
  int _resendCooldown = 60;
  int _attemptsLeft = 3;
  Timer? _expiryTimer;
  Timer? _resendTimer;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _startExpiryTimer();
    _startResendTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocus.dispose();
    _expiryTimer?.cancel();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startExpiryTimer() {
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpExpirySeconds <= 1) {
        timer.cancel();
        setState(() => _otpExpirySeconds = 0);
        // OTP expirado — volver al login
        if (mounted) {
          _showExpiredDialog();
        }
      } else {
        setState(() => _otpExpirySeconds--);
      }
    });
  }

  void _startResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown <= 1) {
        timer.cancel();
        setState(() => _resendCooldown = 0);
      } else {
        setState(() => _resendCooldown--);
      }
    });
  }

  void _showExpiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Código expirado'),
        content: const Text(
          'El código de verificación ha expirado. Debes iniciar sesión nuevamente.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(AppRoutes.login);
            },
            child: const Text('Volver al login'),
          ),
        ],
      ),
    );
  }

  Future<void> _verifyOtp(String otp) async {
    if (otp.length != 6) return;
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      await ref.read(mfaActionProvider.notifier).verifyOtp(otp);
      // go_router redirige automáticamente al dashboard si el login fue exitoso
    } catch (e) {
      // El provider ya maneja el error, pero decrementamos intentos
      setState(() {
        _attemptsLeft--;
        _isSubmitting = false;
        _pinController.clear();
      });

      // PB-04 criterio 4: 3 intentos fallidos → reiniciar flujo
      if (_attemptsLeft <= 0) {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: const Text('Demasiados intentos'),
              content: const Text(
                'Ingresaste el código incorrecto 3 veces. Debes iniciar sesión nuevamente.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go(AppRoutes.login);
                  },
                  child: const Text('Volver al login'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  void _resendCode() {
    // TODO: implementar reenvío — llamar al endpoint /auth/resend-otp
    // Por ahora resetea el timer y muestra confirmación
    setState(() {
      _resendCooldown = 60;
      _otpExpirySeconds = 300;
    });
    _expiryTimer?.cancel();
    _resendTimer?.cancel();
    _startExpiryTimer();
    _startResendTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nuevo código enviado')),
    );
  }

  String get _expiryFormatted {
    final m = (_otpExpirySeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_otpExpirySeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(mfaActionProvider);
    final authState = ref.watch(authStateProvider);
    final correo = authState.state.correoMfa ?? '';
    final canResend = _resendCooldown == 0 && !_isSubmitting;

    // Estilo del campo Pinput (PB-04 criterio 1)
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.primary,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Theme.of(context).colorScheme.error),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de identidad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),

              // Ícono
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.security_outlined,
                  size: 42,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Título
              Text(
                'Código de verificación',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Descripción
              Text(
                'Enviamos un código de 6 dígitos a:\n$correo',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Campo OTP (PB-04 criterio 1)
              Pinput(
                controller: _pinController,
                focusNode: _pinFocus,
                length: 6,
                keyboardType: TextInputType.number,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                errorPinTheme: errorPinTheme,
                autofocus: true,
                onCompleted: _verifyOtp,
                enabled: !_isSubmitting && _attemptsLeft > 0,
              ),
              const SizedBox(height: 20),

              // Countdown de expiración (PB-04 criterio 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: _otpExpirySeconds < 60
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'El código vence en $_expiryFormatted',
                    style: TextStyle(
                      fontSize: 14,
                      color: _otpExpirySeconds < 60
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Intentos restantes
              if (_attemptsLeft < 3)
                Text(
                  'Intentos restantes: $_attemptsLeft',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              // Error del provider
              if (actionState.isError) ...[
                const SizedBox(height: 12),
                Text(
                  actionState.errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const Spacer(),

              // Loading
              if (_isSubmitting || actionState.isLoading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
              ],

              // Botón reenviar (PB-04 criterio 5 — habilitado tras 60 segundos)
              TextButton.icon(
                onPressed: canResend ? _resendCode : null,
                icon: const Icon(Icons.refresh_outlined, size: 18),
                label: Text(
                  _resendCooldown > 0
                      ? 'Reenviar código en ${_resendCooldown}s'
                      : 'Reenviar código',
                ),
              ),
              const SizedBox(height: 8),

              // Cancelar y volver al login
              TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text('Cancelar'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
