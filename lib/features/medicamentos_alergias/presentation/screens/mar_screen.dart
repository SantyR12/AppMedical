import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/mar_model.dart';
import '../../providers/prescription_provider.dart';

class MarScreen extends ConsumerWidget {
  const MarScreen({super.key, required this.pacienteId});
  final String pacienteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(marProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.entries.isEmpty && !state.isLoading) {
        ref.read(marProvider.notifier).loadEntries(pacienteId);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Administración de medicamentos')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.hasError
              ? Center(child: Text(state.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)))
              : state.entries.isEmpty
                  ? const Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.medication_outlined, size: 48, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Sin administraciones programadas'),
                      ],
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.entries.length,
                      itemBuilder: (_, i) => _MarEntryCard(
                        entry: state.entries[i],
                        onRegister: () => _showRegisterDialog(context, ref, state.entries[i]),
                      ),
                    ),
    );
  }

  void _showRegisterDialog(BuildContext context, WidgetRef ref, MarEntryModel entry) {
    showDialog(context: context,
      builder: (_) => _RegisterAdminDialog(entry: entry, ref: ref));
  }
}

class _MarEntryCard extends StatelessWidget {
  const _MarEntryCard({required this.entry, required this.onRegister});
  final MarEntryModel entry;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final pendiente = entry.horaReal == null;
    final horaStr = DateFormat('HH:mm').format(entry.horaProgramada);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: pendiente ? null : Colors.grey.shade50,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: pendiente ? Colors.orange.shade100 : Colors.green.shade100,
          child: Icon(
            pendiente ? Icons.access_time_outlined : Icons.check_circle_outline,
            color: pendiente ? Colors.orange : Colors.green,
          ),
        ),
        title: Text(entry.nombreMedicamento ?? '—',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          '${entry.dosisPrescrita ?? '—'} · Programado: $horaStr'
          '${entry.horaReal != null ? '\nAdministrado: ${DateFormat('HH:mm').format(entry.horaReal!)}' : ''}',
        ),
        isThreeLine: entry.horaReal != null,
        trailing: pendiente
            ? ElevatedButton(onPressed: onRegister, child: const Text('Registrar'))
            : Chip(
                label: Text(entry.resultado.name, style: const TextStyle(fontSize: 11)),
                backgroundColor: Colors.green.shade100,
              ),
      ),
    );
  }
}

class _RegisterAdminDialog extends StatefulWidget {
  const _RegisterAdminDialog({required this.entry, required this.ref});
  final MarEntryModel entry;
  final WidgetRef ref;

  @override
  State<_RegisterAdminDialog> createState() => _RegisterAdminDialogState();
}

class _RegisterAdminDialogState extends State<_RegisterAdminDialog> {
  ResultadoAdministracion _resultado = ResultadoAdministracion.administrado;
  final _obsCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() { _obsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Registrar — ${widget.entry.nombreMedicamento ?? ''}'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownButtonFormField<ResultadoAdministracion>(
          value: _resultado,
          decoration: const InputDecoration(labelText: 'Resultado', border: OutlineInputBorder()),
          items: ResultadoAdministracion.values.map((r) => DropdownMenuItem(
            value: r, child: Text(r.name.replaceAll('_', ' ')))).toList(),
          onChanged: (v) => setState(() => _resultado = v!),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _obsCtrl,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Observaciones (opcional)', border: OutlineInputBorder()),
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _saving ? null : () async {
            setState(() => _saving = true);
            await widget.ref.read(marProvider.notifier).register(
              RegisterMarEntryRequest(
                prescripcionId: widget.entry.prescripcionId,
                horaReal: DateTime.now(),
                resultado: _resultado,
                observaciones: _obsCtrl.text.trim().isEmpty ? null : _obsCtrl.text.trim(),
              ),
            );
            if (context.mounted) Navigator.pop(context);
          },
          child: _saving
              ? const SizedBox(width: 18, height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Confirmar'),
        ),
      ],
    );
  }
}
