import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../shared/widgets/sgp_text_field.dart';
import '../../domain/models/allergy_model.dart';
import '../../providers/allergy_provider.dart';

/// PB-20: Formulario de registro de alergias.
///
/// Criterios implementados:
/// 1. Campos: agente (autocompletado), tipo reacción, severidad,
///    fecha diagnóstico, observaciones
/// 2. Un paciente puede tener múltiples alergias registradas
/// 3. Estado activa/inactiva — solo médicos pueden cambiar (backend valida)
/// 4. Agente usa la misma BD de medicamentos que prescripciones
/// 5. Validación de campos obligatorios antes de guardar
class AllergyFormScreen extends ConsumerStatefulWidget {
  const AllergyFormScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  ConsumerState<AllergyFormScreen> createState() =>
      _AllergyFormScreenState();
}

class _AllergyFormScreenState extends ConsumerState<AllergyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _agenteController = TextEditingController();
  final _observacionesController = TextEditingController();

  ReactionType? _tipoReaccion;
  AllergySeverity? _severidad;
  DateTime? _fechaDiagnostico;

  @override
  void dispose() {
    _agenteController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_tipoReaccion == null || _severidad == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Selecciona el tipo de reacción y la severidad'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final request = CreateAllergyRequest(
      pacienteId: widget.pacienteId,
      agenteCausante: _agenteController.text.trim(),
      tipoReaccion: _tipoReaccion!,
      severidad: _severidad!,
      fechaDiagnostico: _fechaDiagnostico,
      observaciones: _observacionesController.text.trim().isEmpty
          ? null
          : _observacionesController.text.trim(),
    );

    await ref.read(allergyFormProvider.notifier).submit(request);

    final formState = ref.read(allergyFormProvider);
    if (formState.isSuccess && mounted) {
      Navigator.pop(context, true); // true = se guardó correctamente
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // La fecha no puede ser futura (similar a PB-10 criterio 4)
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
    );
    if (picked != null) setState(() => _fechaDiagnostico = picked);
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(allergyFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar alergia'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------------------------------------------------------------
                // Agente causante — autocompletado con BD de medicamentos
                // PB-20 criterio 4: misma BD que prescripciones
                // ----------------------------------------------------------------
                _SectionLabel('Agente causante *'),
                TypeAheadField<MedicationModel>(
                  controller: _agenteController,
                  suggestionsCallback: (query) async {
                    if (query.length < 2) return [];
                    final result = await ref.read(
                        medicationSuggestionsProvider(query).future);
                    return result;
                  },
                  itemBuilder: (context, medication) {
                    return ListTile(
                      title: Text(medication.nombreGenerico),
                      subtitle: medication.nombreComercial != null
                          ? Text(medication.nombreComercial!)
                          : null,
                      dense: true,
                    );
                  },
                  onSelected: (medication) {
                    _agenteController.text = medication.nombreGenerico;
                  },
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Ej: Penicilina, Maní, Polen...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'El agente causante es obligatorio'
                          : null,
                    );
                  },
                  emptyBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Sin sugerencias — escribe el nombre manualmente'),
                  ),
                ),
                const FormGap(height: 20),

                // ----------------------------------------------------------------
                // Tipo de reacción (PB-20 criterio 1)
                // ----------------------------------------------------------------
                _SectionLabel('Tipo de reacción *'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: ReactionType.values.map((tipo) {
                    final isSelected = _tipoReaccion == tipo;
                    return ChoiceChip(
                      label: Text(_labelReaction(tipo)),
                      selected: isSelected,
                      onSelected: (_) =>
                          setState(() => _tipoReaccion = tipo),
                      selectedColor:
                          Theme.of(context).colorScheme.errorContainer,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onErrorContainer
                            : null,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                const FormGap(height: 20),

                // ----------------------------------------------------------------
                // Severidad (PB-20 criterio 1)
                // ----------------------------------------------------------------
                _SectionLabel('Severidad *'),
                const SizedBox(height: 8),
                Row(
                  children: AllergySeverity.values.map((sev) {
                    final isSelected = _severidad == sev;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _severidad = sev),
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _severityColor(sev, context)
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? _severityColor(sev, context)
                                  : Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _severityIcon(sev),
                                size: 20,
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sev.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const FormGap(height: 20),

                // ----------------------------------------------------------------
                // Fecha de diagnóstico (opcional)
                // ----------------------------------------------------------------
                _SectionLabel('Fecha de diagnóstico'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outlineVariant),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 18,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant),
                        const SizedBox(width: 12),
                        Text(
                          _fechaDiagnostico != null
                              ? '${_fechaDiagnostico!.day.toString().padLeft(2, '0')}/'
                                  '${_fechaDiagnostico!.month.toString().padLeft(2, '0')}/'
                                  '${_fechaDiagnostico!.year}'
                              : 'Seleccionar fecha',
                          style: TextStyle(
                            color: _fechaDiagnostico != null
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const FormGap(height: 16),

                // ----------------------------------------------------------------
                // Observaciones (opcional)
                // ----------------------------------------------------------------
                SgpTextField(
                  label: 'Observaciones adicionales',
                  hint: 'Describe los síntomas, tratamiento previo...',
                  controller: _observacionesController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                ),
                const FormGap(height: 28),

                // Error del servidor
                if (formState.isError) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            color:
                                Theme.of(context).colorScheme.error,
                            size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            formState.errorMessage!,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FormGap(),
                ],

                // Botón guardar
                ElevatedButton(
                  onPressed: formState.isLoading ? null : _submit,
                  child: formState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Registrar alergia'),
                ),
                const FormGap(),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelReaction(ReactionType tipo) {
    switch (tipo) {
      case ReactionType.anafilaxia:
        return 'Anafilaxia';
      case ReactionType.urticaria:
        return 'Urticaria';
      case ReactionType.angioedema:
        return 'Angioedema';
      case ReactionType.intolerancia:
        return 'Intolerancia';
      case ReactionType.otra:
        return 'Otra';
    }
  }

  Color _severityColor(AllergySeverity sev, BuildContext context) {
    switch (sev) {
      case AllergySeverity.leve:
        return Colors.green.shade600;
      case AllergySeverity.moderada:
        return Colors.orange.shade600;
      case AllergySeverity.grave:
        return Colors.red.shade600;
      case AllergySeverity.mortal:
        return Colors.red.shade900;
    }
  }

  IconData _severityIcon(AllergySeverity sev) {
    switch (sev) {
      case AllergySeverity.leve:
        return Icons.info_outline;
      case AllergySeverity.moderada:
        return Icons.warning_amber_outlined;
      case AllergySeverity.grave:
        return Icons.dangerous_outlined;
      case AllergySeverity.mortal:
        return Icons.skull_outlined;
    }
  }
}

/// Etiqueta de sección dentro del formulario
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
