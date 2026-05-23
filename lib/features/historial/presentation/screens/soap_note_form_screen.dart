import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/soap_note_model.dart';
import '../../providers/soap_note_provider.dart';

/// PB-11: Formulario de nota SOAP para registrar una evolución clínica.
/// Secciones: Subjetivo · Objetivo · Análisis · Plan
class SoapNoteFormScreen extends ConsumerStatefulWidget {
  const SoapNoteFormScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
  });

  final String pacienteId;
  final String historiaClinicaId;

  @override
  ConsumerState<SoapNoteFormScreen> createState() => _SoapNoteFormScreenState();
}

class _SoapNoteFormScreenState extends ConsumerState<SoapNoteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _subjetivoCtrl  = TextEditingController();
  final _objetivoCtrl   = TextEditingController();
  final _analisisCtrl   = TextEditingController();
  final _planCtrl       = TextEditingController();

  @override
  void dispose() {
    _subjetivoCtrl.dispose();
    _objetivoCtrl.dispose();
    _analisisCtrl.dispose();
    _planCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final request = CreateSoapNoteRequest(
      historiaClinicaId: widget.historiaClinicaId,
      pacienteId: widget.pacienteId,
      subjetivo: _subjetivoCtrl.text.trim(),
      objetivo: _objetivoCtrl.text.trim(),
      analisis: _analisisCtrl.text.trim(),
      plan: _planCtrl.text.trim(),
    );

    final ok = await ref.read(soapNoteProvider.notifier).createNote(request);

    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nota SOAP guardada')),
      );
      Navigator.pop(context, true);
    } else {
      final error = ref.read(soapNoteProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Error al guardar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = ref.watch(soapNoteProvider).isSaving;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva nota SOAP'),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _submit,
            child: isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Guardar'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SoapSection(
              label: 'S — Subjetivo',
              hint: 'Síntomas y motivo de consulta reportados por el paciente',
              controller: _subjetivoCtrl,
              color: Colors.blue.shade50,
            ),
            const SizedBox(height: 12),
            _SoapSection(
              label: 'O — Objetivo',
              hint: 'Hallazgos del examen físico, signos vitales, laboratorios',
              controller: _objetivoCtrl,
              color: Colors.green.shade50,
            ),
            const SizedBox(height: 12),
            _SoapSection(
              label: 'A — Análisis',
              hint: 'Interpretación clínica y diagnóstico',
              controller: _analisisCtrl,
              color: Colors.orange.shade50,
            ),
            const SizedBox(height: 12),
            _SoapSection(
              label: 'P — Plan',
              hint: 'Tratamiento, medicamentos, seguimiento, interconsultas',
              controller: _planCtrl,
              color: Colors.purple.shade50,
            ),
          ],
        ),
      ),
    );
  }
}

class _SoapSection extends StatelessWidget {
  const _SoapSection({
    required this.label,
    required this.hint,
    required this.controller,
    required this.color,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            minLines: 3,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (v.trim().length < 5) {
                return 'Mínimo 5 caracteres';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
