import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/diagnosis_model.dart';
import '../../providers/diagnosis_provider.dart';
import 'diagnosis_form_screen.dart';

class ProblemListScreen extends ConsumerStatefulWidget {
  const ProblemListScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
  });
  final String pacienteId;
  final String historiaClinicaId;

  @override
  ConsumerState<ProblemListScreen> createState() => _ProblemListScreenState();
}

class _ProblemListScreenState extends ConsumerState<ProblemListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(diagnosisProvider.notifier).loadProblems(widget.pacienteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(diagnosisProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de problemas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => DiagnosisFormScreen(
            historiaClinicaId: widget.historiaClinicaId,
            pacienteId: widget.pacienteId,
          ),
        )),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo diagnóstico'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.diagnoses.isEmpty
              ? const Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('Sin problemas activos registrados'),
                  ],
                ))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.diagnoses.length,
                  itemBuilder: (_, i) => _DiagnosisCard(
                    diagnosis: state.diagnoses[i], ref: ref),
                ),
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard({required this.diagnosis, required this.ref});
  final DiagnosisModel diagnosis;
  final WidgetRef ref;

  Color _estadoColor(EstadoDiagnostico e) {
    switch (e) {
      case EstadoDiagnostico.activo:   return Colors.red.shade100;
      case EstadoDiagnostico.cronico:  return Colors.orange.shade100;
      case EstadoDiagnostico.resuelto: return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 48, height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(diagnosis.codigoCie10,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(diagnosis.descripcion,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        subtitle: Row(children: [
          _Chip(diagnosis.tipo.name),
          const SizedBox(width: 4),
          _Chip(diagnosis.estado.name, color: _estadoColor(diagnosis.estado)),
        ]),
        trailing: PopupMenuButton<EstadoDiagnostico>(
          tooltip: 'Cambiar estado',
          onSelected: (estado) => ref.read(diagnosisProvider.notifier)
              .updateEstado(id: diagnosis.id, estado: estado),
          itemBuilder: (_) => EstadoDiagnostico.values
              .map((e) => PopupMenuItem(value: e, child: Text(e.name))).toList(),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label, {this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
