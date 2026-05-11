import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sgp_app/shared/utils/validators.dart';
import 'package:sgp_app/shared/widgets/sgp_text_field.dart';
import 'package:sgp_app/features/historial/domain/models/patient_model.dart';
import 'package:sgp_app/features/historial/providers/historial_provider.dart';
import 'package:sgp_app/features/historial/data/repositories/historial_repository.dart';

/// PB-10 · Registro de datos demográficos del paciente.
///
/// Criterios implementados:
/// 1. Campos: nombre completo, tipo documento (CC/TI/CE/PAS), número,
///    fecha de nacimiento, sexo, dirección, teléfono, correo
/// 2. Sección de contacto de emergencia opcional
/// 3. Validación del formato de número de documento según tipo
/// 4. La fecha de nacimiento no puede ser futura
/// 5. Número de documento único por tipo (lo valida el backend — error 409)
class NewPatientScreen extends ConsumerStatefulWidget {
  const NewPatientScreen({super.key});

  @override
  ConsumerState<NewPatientScreen> createState() => _NewPatientScreenState();
}

class _NewPatientScreenState extends ConsumerState<NewPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores — datos principales
  final _nombreController = TextEditingController();
  final _documentoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();

  // Controladores — contacto de emergencia
  final _emergNombreController = TextEditingController();
  final _emergTelefonoController = TextEditingController();

  DocumentType _tipoDocumento = DocumentType.cc;
  Sex _sexo = Sex.masculino;
  DateTime? _fechaNacimiento;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nombreController.dispose();
    _documentoController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _emergNombreController.dispose();
    _emergTelefonoController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Validación del número de documento según tipo (PB-10 criterio 3)
  // -------------------------------------------------------------------------
  String? _validateDocumento(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número de documento es obligatorio';
    }
    switch (_tipoDocumento) {
      case DocumentType.cc:
        // CC: 6 a 10 dígitos numéricos
        if (!RegExp(r'^\d{6,10}$').hasMatch(value.trim())) {
          return 'La CC debe tener entre 6 y 10 dígitos numéricos';
        }
      case DocumentType.ti:
        // TI: 10 a 11 dígitos numéricos
        if (!RegExp(r'^\d{10,11}$').hasMatch(value.trim())) {
          return 'La TI debe tener entre 10 y 11 dígitos';
        }
      case DocumentType.ce:
        // CE: 6 a 7 dígitos numéricos
        if (!RegExp(r'^\d{6,7}$').hasMatch(value.trim())) {
          return 'La CE debe tener entre 6 y 7 dígitos';
        }
      case DocumentType.pas:
        // Pasaporte: alfanumérico 5 a 9 caracteres
        if (!RegExp(r'^[A-Za-z0-9]{5,9}$').hasMatch(value.trim())) {
          return 'El pasaporte debe tener entre 5 y 9 caracteres alfanuméricos';
        }
    }
    return null;
  }

  // -------------------------------------------------------------------------
  // Selector de fecha de nacimiento (PB-10 criterio 4: no puede ser futura)
  // -------------------------------------------------------------------------
  Future<void> _pickFechaNacimiento() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // no permite fechas futuras
      helpText: 'Fecha de nacimiento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      locale: const Locale('es', 'CO'),
    );
    if (picked != null) setState(() => _fechaNacimiento = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fechaNacimiento == null) {
      setState(() => _errorMessage = 'Selecciona la fecha de nacimiento');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final request = CreateClinicalRecordRequest(
      nombreCompleto: _nombreController.text.trim(),
      tipoDocumento: _tipoDocumento,
      numeroDocumento: _documentoController.text.trim(),
      fechaNacimiento: _fechaNacimiento!,
      sexo: _sexo,
      direccion: _direccionController.text.trim().isEmpty
          ? null
          : _direccionController.text.trim(),
      telefono: _telefonoController.text.trim().isEmpty
          ? null
          : _telefonoController.text.trim(),
      correo: _correoController.text.trim().isEmpty
          ? null
          : _correoController.text.trim(),
      contactoEmergencia: (_emergNombreController.text.trim().isNotEmpty ||
              _emergTelefonoController.text.trim().isNotEmpty)
          ? EmergencyContact(
              nombre: _emergNombreController.text.trim().isEmpty
                  ? null
                  : _emergNombreController.text.trim(),
              telefono: _emergTelefonoController.text.trim().isEmpty
                  ? null
                  : _emergTelefonoController.text.trim(),
            )
          : null,
    );

    try {
      final record = await ref
          .read(historialRepositoryProvider)
          .createRecord(request);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Historia clínica creada para ${record.paciente.nombreCompleto}'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        // Navegar a la historia clínica recién creada
        context.go('/patients/${record.paciente.id}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo paciente'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── DATOS PRINCIPALES ───────────────────────────────────────
                _SectionTitle('Datos del paciente'),
                const SizedBox(height: 12),

                // Nombre completo
                SgpTextField(
                  label: 'Nombre completo *',
                  hint: 'Ej: María García López',
                  controller: _nombreController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: SgpValidators.fullName,
                ),
                const FormGap(height: 14),

                // Tipo de documento — selector horizontal
                _SectionLabel('Tipo de documento *'),
                const SizedBox(height: 8),
                Row(
                  children: DocumentType.values.map((tipo) {
                    final isSelected = _tipoDocumento == tipo;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _tipoDocumento = tipo;
                            _documentoController.clear();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tipo.name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const FormGap(height: 14),

                // Número de documento
                SgpTextField(
                  label: 'Número de documento *',
                  controller: _documentoController,
                  keyboardType: _tipoDocumento == DocumentType.pas
                      ? TextInputType.text
                      : TextInputType.number,
                  prefixIcon: const Icon(Icons.badge_outlined),
                  inputFormatters: _tipoDocumento != DocumentType.pas
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  validator: _validateDocumento,
                ),
                const FormGap(height: 14),

                // Fecha de nacimiento (PB-10 criterio 4)
                _SectionLabel('Fecha de nacimiento *'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickFechaNacimiento,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _fechaNacimiento == null && _errorMessage != null
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.outlineVariant),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(width: 12),
                        Text(
                          _fechaNacimiento != null
                              ? '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/'
                                  '${_fechaNacimiento!.month.toString().padLeft(2, '0')}/'
                                  '${_fechaNacimiento!.year}'
                              : 'DD/MM/AAAA',
                          style: TextStyle(
                            fontSize: 14,
                            color: _fechaNacimiento != null
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        if (_fechaNacimiento != null)
                          Text(
                            '(${_calcularEdad()} años)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const FormGap(height: 14),

                // Sexo
                _SectionLabel('Sexo *'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: Sex.values.map((s) {
                    final isSelected = _sexo == s;
                    return ChoiceChip(
                      label: Text(_labelSex(s)),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _sexo = s),
                      selectedColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const FormGap(height: 14),

                // Dirección
                SgpTextField(
                  label: 'Dirección',
                  hint: 'Ej: Cra 5 # 12-34, Pasto',
                  controller: _direccionController,
                  keyboardType: TextInputType.streetAddress,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                const FormGap(height: 14),

                // Teléfono
                SgpTextField(
                  label: 'Teléfono',
                  hint: 'Ej: 3001234567',
                  controller: _telefonoController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                ),
                const FormGap(height: 14),

                // Correo electrónico
                SgpTextField(
                  label: 'Correo electrónico',
                  hint: 'paciente@correo.com',
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null; // opcional
                    return SgpValidators.email(v);
                  },
                ),

                // ── CONTACTO DE EMERGENCIA (opcional) ──────────────────────
                const FormGap(height: 24),
                _SectionTitle('Contacto de emergencia'),
                const SizedBox(height: 4),
                Text(
                  'Opcional pero recomendado',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),

                SgpTextField(
                  label: 'Nombre del contacto',
                  hint: 'Nombre completo',
                  controller: _emergNombreController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.contact_emergency_outlined),
                ),
                const FormGap(height: 14),

                SgpTextField(
                  label: 'Teléfono del contacto',
                  hint: 'Ej: 3001234567',
                  controller: _emergTelefonoController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_in_talk_outlined),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                ),

                // Error general
                const FormGap(height: 20),
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                            size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FormGap(),
                ],

                // Botones
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Crear historia clínica'),
                ),
                const FormGap(),
                OutlinedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _calcularEdad() {
    if (_fechaNacimiento == null) return 0;
    final hoy = DateTime.now();
    int edad = hoy.year - _fechaNacimiento!.year;
    if (hoy.month < _fechaNacimiento!.month ||
        (hoy.month == _fechaNacimiento!.month &&
            hoy.day < _fechaNacimiento!.day)) {
      edad--;
    }
    return edad;
  }

  String _labelSex(Sex s) {
    switch (s) {
      case Sex.masculino:
        return 'Masculino';
      case Sex.femenino:
        return 'Femenino';
      case Sex.otro:
        return 'Otro';
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ));
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ));
  }
}
