import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:sgp_app/shared/widgets/sgp_text_field.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/models/allergy_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/providers/allergy_provider.dart';

/// PB-20: Alergias del paciente — lista completa + formulario de registro.
class AllergyFormScreen extends ConsumerWidget {
  const AllergyFormScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allergyListProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.allergies.isEmpty && !state.isLoading) {
        ref.read(allergyListProvider.notifier).loadAllergies(pacienteId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alergias'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.mounted) Navigator.of(context).maybePop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Registrar alergia'),
        onPressed: () => _showForm(context, ref),
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, AllergyListState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(state.errorMessage!,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () =>
                  ref.read(allergyListProvider.notifier).loadAllergies(pacienteId),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (state.allergies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_outlined,
                size: 56,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            const Text('Sin alergias registradas'),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showForm(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Registrar primera alergia'),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: state.allergies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) => _AllergyCard(
        allergy: state.allergies[i],
        onToggle: () =>
            ref.read(allergyListProvider.notifier).toggleStatus(state.allergies[i]),
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AllergyForm(
        pacienteId: pacienteId,
        onSaved: () =>
            ref.read(allergyListProvider.notifier).loadAllergies(pacienteId),
      ),
    );
  }
}

// ── Tarjeta de alergia ────────────────────────────────────────────────────────

class _AllergyCard extends StatelessWidget {
  const _AllergyCard({required this.allergy, required this.onToggle});

  final AllergyModel allergy;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isActive = allergy.estado == AllergyStatus.activa;
    final color = _severityColor(allergy.severidad);

    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(_severityIcon(allergy.severidad), color: color, size: 20),
        ),
        title: Text(
          allergy.agenteCausante,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            _Chip(
              label: allergy.severidad.name,
              color: color,
            ),
            const SizedBox(width: 6),
            _Chip(
              label: _labelReaction(allergy.tipoReaccion),
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 6),
            _Chip(
              label: isActive ? 'Activa' : 'Inactiva',
              color: isActive ? Colors.green : Colors.grey,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (allergy.fechaDiagnostico != null)
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Diagnóstico',
                    value: _formatDate(allergy.fechaDiagnostico!),
                  ),
                if (allergy.observaciones != null &&
                    allergy.observaciones!.isNotEmpty)
                  _DetailRow(
                    icon: Icons.notes_outlined,
                    label: 'Observaciones',
                    value: allergy.observaciones!,
                  ),
                if (allergy.creadoPor != null)
                  _DetailRow(
                    icon: Icons.person_outline,
                    label: 'Registrado por',
                    value: allergy.creadoPor!,
                  ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: onToggle,
                    icon: Icon(
                      isActive ? Icons.toggle_off_outlined : Icons.toggle_on_outlined,
                      size: 18,
                    ),
                    label: Text(isActive ? 'Marcar inactiva' : 'Marcar activa'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isActive ? Colors.grey : Colors.green,
                      side: BorderSide(
                          color: isActive ? Colors.grey : Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _severityColor(AllergySeverity sev) => switch (sev) {
        AllergySeverity.leve => Colors.green.shade600,
        AllergySeverity.moderada => Colors.orange.shade600,
        AllergySeverity.grave => Colors.red.shade600,
        AllergySeverity.mortal => Colors.red.shade900,
      };

  IconData _severityIcon(AllergySeverity sev) => switch (sev) {
        AllergySeverity.leve => Icons.info_outline,
        AllergySeverity.moderada => Icons.warning_amber_outlined,
        AllergySeverity.grave => Icons.dangerous_outlined,
        AllergySeverity.mortal => Icons.coronavirus_outlined,
      };

  String _labelReaction(ReactionType tipo) => switch (tipo) {
        ReactionType.anafilaxia => 'Anafilaxia',
        ReactionType.urticaria => 'Urticaria',
        ReactionType.angioedema => 'Angioedema',
        ReactionType.intolerancia => 'Intolerancia',
        ReactionType.otra => 'Otra',
      };

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(
      {required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// ── Formulario de nueva alergia (modal) ───────────────────────────────────────

class _AllergyForm extends ConsumerStatefulWidget {
  const _AllergyForm({required this.pacienteId, required this.onSaved});
  final String pacienteId;
  final VoidCallback onSaved;

  @override
  ConsumerState<_AllergyForm> createState() => _AllergyFormState();
}

class _AllergyFormState extends ConsumerState<_AllergyForm> {
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
          content: Text('Selecciona el tipo de reacción y la severidad'),
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
      widget.onSaved();
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
    );
    if (picked != null) setState(() => _fechaDiagnostico = picked);
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(allergyFormProvider);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nueva alergia',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 16),

              // Agente causante
              const Text('Agente causante *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TypeAheadField<MedicationModel>(
                controller: _agenteController,
                suggestionsCallback: (query) async {
                  if (query.length < 2) return [];
                  return ref.read(medicationSuggestionsProvider(query).future);
                },
                itemBuilder: (context, med) => ListTile(
                  title: Text(med.nombreGenerico),
                  subtitle: med.nombreComercial != null
                      ? Text(med.nombreComercial!)
                      : null,
                  dense: true,
                ),
                onSelected: (med) =>
                    _agenteController.text = med.nombreGenerico,
                builder: (context, controller, focusNode) => TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Ej: Penicilina, Maní, Polen...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'El agente causante es obligatorio'
                      : null,
                ),
                emptyBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Sin sugerencias — escribe el nombre manualmente'),
                ),
              ),
              const SizedBox(height: 16),

              // Tipo de reacción
              const Text('Tipo de reacción *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: ReactionType.values.map((tipo) {
                  final sel = _tipoReaccion == tipo;
                  return ChoiceChip(
                    label: Text(_labelReaction(tipo)),
                    selected: sel,
                    onSelected: (_) => setState(() => _tipoReaccion = tipo),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Severidad
              const Text('Severidad *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: AllergySeverity.values.map((sev) {
                  final sel = _severidad == sev;
                  return ChoiceChip(
                    label: Text(sev.name),
                    selected: sel,
                    onSelected: (_) => setState(() => _severidad = sev),
                    selectedColor: _severityColor(sev).withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      color: sel ? _severityColor(sev) : null,
                      fontWeight: sel ? FontWeight.w700 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Fecha de diagnóstico
              const Text('Fecha de diagnóstico (opcional)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined, size: 18),
                label: Text(_fechaDiagnostico != null
                    ? '${_fechaDiagnostico!.day.toString().padLeft(2, '0')}/${_fechaDiagnostico!.month.toString().padLeft(2, '0')}/${_fechaDiagnostico!.year}'
                    : 'Seleccionar fecha'),
                style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12)),
              ),
              const SizedBox(height: 16),

              // Observaciones
              SgpTextField(
                label: 'Observaciones (opcional)',
                hint: 'Describe síntomas, tratamientos previos...',
                controller: _observacionesController,
                keyboardType: TextInputType.multiline,
                maxLength: 500,
              ),

              if (formState.isError) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formState.errorMessage!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                        fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              FilledButton(
                onPressed: formState.isLoading ? null : _submit,
                child: formState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Registrar alergia'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _severityColor(AllergySeverity sev) => switch (sev) {
        AllergySeverity.leve => Colors.green.shade600,
        AllergySeverity.moderada => Colors.orange.shade600,
        AllergySeverity.grave => Colors.red.shade600,
        AllergySeverity.mortal => Colors.red.shade900,
      };

  String _labelReaction(ReactionType tipo) => switch (tipo) {
        ReactionType.anafilaxia => 'Anafilaxia',
        ReactionType.urticaria => 'Urticaria',
        ReactionType.angioedema => 'Angioedema',
        ReactionType.intolerancia => 'Intolerancia',
        ReactionType.otra => 'Otra',
      };
}

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
