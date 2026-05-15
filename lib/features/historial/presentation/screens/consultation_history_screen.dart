import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router.dart';
import '../../domain/models/soap_note_model.dart';
import '../../providers/soap_note_provider.dart';

/// PB-12: Historial de consultas — lista paginada de notas SOAP del paciente.
class ConsultationHistoryScreen extends ConsumerWidget {
  const ConsultationHistoryScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
  });

  final String pacienteId;
  final String historiaClinicaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(soapNoteProvider);

    ref.listen(soapNoteProvider, (_, __) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.notes.isEmpty && !state.isLoading) {
        ref.read(soapNoteProvider.notifier).loadNotes(pacienteId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de consultas'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await context.push<bool>(
            AppRoutes.soapNoteForm
                .replaceFirst(':id', pacienteId)
                .replaceFirst(':hcId', historiaClinicaId),
          );
          if (added == true) {
            ref.read(soapNoteProvider.notifier).loadNotes(pacienteId);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nueva nota'),
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, SoapNoteListState state) {
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error)),
          ],
        ),
      );
    }

    if (state.notes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text('Sin consultas registradas',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: state.notes.length,
      itemBuilder: (context, i) => SoapNoteCard(note: state.notes[i]),
    );
  }
}

// =============================================================================
// CARD expandible para cada nota SOAP
// =============================================================================

class SoapNoteCard extends StatelessWidget {
  const SoapNoteCard({super.key, required this.note});

  final SoapNoteModel note;

  @override
  Widget build(BuildContext context) {
    final fecha = note.creadoEn != null ? _formatDate(note.creadoEn!) : '—';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: const Icon(Icons.description_outlined),
        title: Text(
          'Consulta — $fecha',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: note.creadoPor != null
            ? Text('Dr. ${note.creadoPor}',
                style: const TextStyle(fontSize: 12))
            : null,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _SoapField('S — Subjetivo', note.subjetivo, Colors.blue.shade50),
          const SizedBox(height: 8),
          _SoapField('O — Objetivo', note.objetivo, Colors.green.shade50),
          const SizedBox(height: 8),
          _SoapField('A — Análisis', note.analisis, Colors.orange.shade50),
          const SizedBox(height: 8),
          _SoapField('P — Plan', note.plan, Colors.purple.shade50),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _SoapField extends StatelessWidget {
  const _SoapField(this.label, this.value, this.color);

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
