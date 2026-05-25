import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/soap_repository.dart';
import '../../domain/models/soap_note_model.dart';

class SoapNoteScreen extends ConsumerWidget {
  const SoapNoteScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
  });

  final String pacienteId;
  final String historiaClinicaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(soapNotesProvider(pacienteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Notas SOAP')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nueva nota'),
        onPressed: () => _showSoapForm(context, ref),
      ),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 12),
              Text(
                e.toString().replaceFirst('Exception: ', ''),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => ref.invalidate(soapNotesProvider(pacienteId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (notes) {
          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined,
                      size: 56,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  const Text('No hay notas SOAP registradas'),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showSoapForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar primera nota'),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _SoapCard(note: notes[i]),
          );
        },
      ),
    );
  }

  void _showSoapForm(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _SoapForm(
        pacienteId: pacienteId,
        historiaClinicaId: historiaClinicaId,
        onSaved: () => ref.invalidate(soapNotesProvider(pacienteId)),
      ),
    );
  }
}

// ── Tarjeta de nota SOAP ─────────────────────────────────────────────────────

class _SoapCard extends StatelessWidget {
  const _SoapCard({required this.note});
  final SoapNoteModel note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Icon(Icons.description_outlined,
              color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        title: Text(
          note.creadoPor ?? 'Médico',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          note.creadoEn != null ? _formatDate(note.creadoEn!) : '',
          style: const TextStyle(fontSize: 12),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SoapField('S — Subjetivo', note.subjetivo),
                _SoapField('O — Objetivo', note.objetivo),
                _SoapField('A — Análisis', note.analisis),
                _SoapField('P — Plan', note.plan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/${d.year}  '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}

class _SoapField extends StatelessWidget {
  const _SoapField(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 0.5)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// ── Formulario SOAP ──────────────────────────────────────────────────────────

class _SoapForm extends ConsumerStatefulWidget {
  const _SoapForm({
    required this.pacienteId,
    required this.historiaClinicaId,
    required this.onSaved,
  });

  final String pacienteId;
  final String historiaClinicaId;
  final VoidCallback onSaved;

  @override
  ConsumerState<_SoapForm> createState() => _SoapFormState();
}

class _SoapFormState extends ConsumerState<_SoapForm> {
  final _formKey = GlobalKey<FormState>();
  final _sCtrl = TextEditingController();
  final _oCtrl = TextEditingController();
  final _aCtrl = TextEditingController();
  final _pCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _sCtrl.dispose();
    _oCtrl.dispose();
    _aCtrl.dispose();
    _pCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(soapRepositoryProvider).createNote(
            historiaClinicaId: widget.historiaClinicaId,
            pacienteId: widget.pacienteId,
            subjetivo: _sCtrl.text.trim(),
            objetivo: _oCtrl.text.trim(),
            analisis: _aCtrl.text.trim(),
            plan: _pCtrl.text.trim(),
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
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                  Text('Nueva nota SOAP',
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
              _SoapTextArea(
                  ctrl: _sCtrl,
                  label: 'S — Subjetivo',
                  hint: 'Síntomas y queja principal del paciente'),
              _SoapTextArea(
                  ctrl: _oCtrl,
                  label: 'O — Objetivo',
                  hint: 'Signos vitales, exploración física, resultados'),
              _SoapTextArea(
                  ctrl: _aCtrl,
                  label: 'A — Análisis / Evaluación',
                  hint: 'Diagnóstico o impresión clínica'),
              _SoapTextArea(
                  ctrl: _pCtrl,
                  label: 'P — Plan',
                  hint: 'Tratamiento, medicamentos, seguimiento'),
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
                        child:
                            CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Guardar nota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SoapTextArea extends StatelessWidget {
  const _SoapTextArea(
      {required this.ctrl, required this.label, required this.hint});
  final TextEditingController ctrl;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
      ),
    );
  }
}
