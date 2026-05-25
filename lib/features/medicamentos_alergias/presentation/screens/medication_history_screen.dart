import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/prescription_model.dart';
import '../../providers/prescription_provider.dart';
import 'prescription_form_screen.dart';

/// PB-16 · Historial de medicamentos activos e históricos del paciente.
///
/// TabBar:
///   Activos   — prescripciones con estado == activa
///   Histórico — prescripciones completadas / canceladas
class MedicationHistoryScreen extends ConsumerStatefulWidget {
  const MedicationHistoryScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  ConsumerState<MedicationHistoryScreen> createState() =>
      _MedicationHistoryScreenState();
}

class _MedicationHistoryScreenState extends ConsumerState<MedicationHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(prescriptionListProvider.notifier)
          .loadPrescriptions(widget.pacienteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(prescriptionListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicamentos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Activos'),
              Tab(text: 'Histórico'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  PrescriptionFormScreen(pacienteId: widget.pacienteId),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Prescribir'),
        ),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.hasError
                ? Center(
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  )
                : TabBarView(
                    children: [
                      _PrescriptionList(
                        prescriptions: state.activas,
                        emptyMsg: 'Sin medicamentos activos',
                        ref: ref,
                      ),
                      _PrescriptionList(
                        prescriptions: state.historicas,
                        emptyMsg: 'Sin historial de medicamentos',
                        ref: ref,
                        readOnly: true,
                      ),
                    ],
                  ),
      ),
    );
  }
}

class _PrescriptionList extends StatelessWidget {
  const _PrescriptionList({
    required this.prescriptions,
    required this.emptyMsg,
    required this.ref,
    this.readOnly = false,
  });

  final List<PrescriptionModel> prescriptions;
  final String emptyMsg;
  final WidgetRef ref;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication_outlined,
                size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(emptyMsg,
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: prescriptions.length,
      itemBuilder: (_, i) => _PrescriptionCard(
        prescription: prescriptions[i],
        ref: ref,
        readOnly: readOnly,
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({
    required this.prescription,
    required this.ref,
    this.readOnly = false,
  });

  final PrescriptionModel prescription;
  final WidgetRef ref;
  final bool readOnly;

  Color _statusColor(PrescriptionStatus s) => switch (s) {
        PrescriptionStatus.activa => Colors.green,
        PrescriptionStatus.completada => Colors.blue,
        PrescriptionStatus.cancelada => Colors.grey,
      };

  String _viaLabel(AdministrationRoute v) => switch (v) {
        AdministrationRoute.oral => 'Oral',
        AdministrationRoute.iv => 'IV',
        AdministrationRoute.im => 'IM',
        AdministrationRoute.subcutanea => 'Subcutánea',
        AdministrationRoute.topica => 'Tópica',
      };

  @override
  Widget build(BuildContext context) {
    final dateStr = prescription.fechaPrescripcion != null
        ? DateFormat('dd/MM/yyyy').format(prescription.fechaPrescripcion!)
        : '—';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.medication_outlined),
        title: Text(
          prescription.medicamentoNombre,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${prescription.dosis} ${prescription.dosisUnidad.name}'
              ' · c/${prescription.frecuenciaHoras}h'
              ' · ${_viaLabel(prescription.viaAdministracion)}',
            ),
            Text(
              '${prescription.duracionDias} días — desde $dateStr',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _statusColor(prescription.estado),
                shape: BoxShape.circle,
              ),
            ),
            if (!readOnly) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.block_outlined, size: 20),
                tooltip: 'Cancelar prescripción',
                onPressed: () => ref
                    .read(prescriptionListProvider.notifier)
                    .cancel(prescription.id),
              ),
            ],
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
