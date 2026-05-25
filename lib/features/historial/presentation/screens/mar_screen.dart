import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mar_repository.dart';
import '../../domain/models/mar_model.dart';

class MarScreen extends ConsumerWidget {
  const MarScreen({super.key, required this.pacienteId});
  final String pacienteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marAsync = ref.watch(marEntriesProvider(pacienteId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Medicación (MAR)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.invalidate(marEntriesProvider(pacienteId)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.medication_outlined),
        label: const Text('Registrar'),
        onPressed: () => _showForm(context, ref),
      ),
      body: marAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 12),
              Text(e.toString().replaceFirst('Exception: ', ''),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () =>
                    ref.invalidate(marEntriesProvider(pacienteId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medication_outlined,
                      size: 56,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  const Text('Sin registros de medicación'),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar administración'),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) => _MarCard(entry: entries[i]),
          );
        },
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _MarForm(
        pacienteId: pacienteId,
        onSaved: () => ref.invalidate(marEntriesProvider(pacienteId)),
      ),
    );
  }
}

// ── Tarjeta MAR ──────────────────────────────────────────────────────────────

class _MarCard extends StatelessWidget {
  const _MarCard({required this.entry});
  final MarEntryModel entry;

  @override
  Widget build(BuildContext context) {
    final color = _resultadoColor(entry.resultado);

    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(_resultadoIcon(entry.resultado),
              color: color, size: 20),
        ),
        title: Text(
          entry.nombreMedicamento ?? 'Medicamento',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            if (entry.dosisPrescrita != null)
              Text('Dosis: ${entry.dosisPrescrita}',
                  style: const TextStyle(fontSize: 12)),
            Text(
              '${_formatDate(entry.horaReal)} · ${entry.administradoPor ?? ''}',
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            if (entry.observaciones != null)
              Text(entry.observaciones!,
                  style: const TextStyle(fontSize: 12,
                      fontStyle: FontStyle.italic)),
          ],
        ),
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(entry.resultadoLabel,
              style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Color _resultadoColor(MarResultado r) {
    switch (r) {
      case MarResultado.administrado:      return Colors.green;
      case MarResultado.omitido:           return Colors.orange;
      case MarResultado.rechazadoPaciente: return Colors.red;
      case MarResultado.contraindicado:    return Colors.red.shade800;
    }
  }

  IconData _resultadoIcon(MarResultado r) {
    switch (r) {
      case MarResultado.administrado:      return Icons.check_circle_outline;
      case MarResultado.omitido:           return Icons.cancel_outlined;
      case MarResultado.rechazadoPaciente: return Icons.block_outlined;
      case MarResultado.contraindicado:    return Icons.warning_amber_outlined;
    }
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}  '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

// ── Formulario MAR ───────────────────────────────────────────────────────────

class _MarForm extends ConsumerStatefulWidget {
  const _MarForm({required this.pacienteId, required this.onSaved});
  final String pacienteId;
  final VoidCallback onSaved;

  @override
  ConsumerState<_MarForm> createState() => _MarFormState();
}

class _MarFormState extends ConsumerState<_MarForm> {
  final _formKey = GlobalKey<FormState>();
  final _prescripcionCtrl = TextEditingController();
  final _dosisCtrl = TextEditingController();
  final _viaCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();
  MarResultado _resultado = MarResultado.administrado;
  DateTime _horaReal = DateTime.now();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _prescripcionCtrl.dispose();
    _dosisCtrl.dispose();
    _viaCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showDateTimePicker(context);
    if (picked != null) setState(() => _horaReal = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(marRepositoryProvider).registerAdministration(
            prescripcionId: _prescripcionCtrl.text.trim(),
            horaReal: _horaReal,
            resultado: _resultado,
            dosisAdministrada: _dosisCtrl.text.trim().isEmpty
                ? null
                : _dosisCtrl.text.trim(),
            viaAdministrada: _viaCtrl.text.trim().isEmpty
                ? null
                : _viaCtrl.text.trim(),
            observaciones: _obsCtrl.text.trim().isEmpty
                ? null
                : _obsCtrl.text.trim(),
          );
      widget.onSaved();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Text('Registrar administración',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _prescripcionCtrl,
                decoration: const InputDecoration(
                  labelText: 'ID de prescripción',
                  hintText: 'UUID de la prescripción activa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.receipt_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Campo requerido'
                    : null,
              ),
              const SizedBox(height: 12),

              // Hora real de administración
              InkWell(
                onTap: _pickTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Hora de administración',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    '${_horaReal.day.toString().padLeft(2, '0')}/'
                    '${_horaReal.month.toString().padLeft(2, '0')}/${_horaReal.year}  '
                    '${_horaReal.hour.toString().padLeft(2, '0')}:${_horaReal.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Resultado
              DropdownButtonFormField<MarResultado>(
                value: _resultado,
                decoration: const InputDecoration(
                  labelText: 'Resultado',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                      value: MarResultado.administrado,
                      child: Text('Administrado')),
                  DropdownMenuItem(
                      value: MarResultado.omitido,
                      child: Text('Omitido')),
                  DropdownMenuItem(
                      value: MarResultado.rechazadoPaciente,
                      child: Text('Rechazado por paciente')),
                  DropdownMenuItem(
                      value: MarResultado.contraindicado,
                      child: Text('Contraindicado')),
                ],
                onChanged: (v) => setState(() => _resultado = v!),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _dosisCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dosis administrada (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _viaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Vía de administración (opcional)',
                  hintText: 'Ej: oral, IV, IM',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _obsCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Observaciones (opcional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 13)),
              ],

              const SizedBox(height: 16),
              FilledButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Guardar registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker(BuildContext context) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 7)),
    lastDate: DateTime.now(),
  );
  if (date == null) return null;
  if (!context.mounted) return null;
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (time == null) return null;
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
