import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/prescription_model.dart';
import '../../providers/prescription_provider.dart';
import 'prescription_form_screen.dart';

class MedicationHistoryScreen extends ConsumerWidget {
  const MedicationHistoryScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
    this.pesoKg,
  });
  final String pacienteId;
  final String historiaClinicaId;
  final double? pesoKg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(prescriptionProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.prescriptions.isEmpty && !state.isLoading) {
        ref.read(prescriptionProvider.notifier).loadPrescriptions(pacienteId);
      }
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicamentos'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Activos'), Tab(text: 'Histórico')],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => PrescriptionFormScreen(
              historiaClinicaId: historiaClinicaId,
              pacienteId: pacienteId,
              pesoKg: pesoKg,
            ),
          )),
          icon: const Icon(Icons.add),
          label: const Text('Prescribir'),
        ),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _PrescriptionList(prescriptions: state.activas,
                      emptyMsg: 'Sin medicamentos activos', ref: ref),
                  _PrescriptionList(prescriptions: state.historicas,
                      emptyMsg: 'Sin historial', ref: ref, readOnly: true),
                ],
              ),
      ),
    );
  }
}

class _PrescriptionList extends StatelessWidget {
  const _PrescriptionList({
    required this.prescriptions, required this.emptyMsg,
    required this.ref, this.readOnly = false,
  });
  final List<PrescriptionModel> prescriptions;
  final String emptyMsg;
  final WidgetRef ref;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.medication_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(emptyMsg),
        ],
      ));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: prescriptions.length,
      itemBuilder: (_, i) => _PrescriptionCard(
        prescription: prescriptions[i], ref: ref, readOnly: readOnly),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({required this.prescription, required this.ref, this.readOnly = false});
  final PrescriptionModel prescription;
  final WidgetRef ref;
  final bool readOnly;

  Color _estadoColor(EstadoPrescripcion e) {
    switch (e) {
      case EstadoPrescripcion.activa:     return Colors.green;
      case EstadoPrescripcion.suspendida: return Colors.orange;
      case EstadoPrescripcion.completada: return Colors.blue;
      case EstadoPrescripcion.vencida:    return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = prescription.creadoEn != null
        ? DateFormat('dd/MM/yyyy').format(prescription.creadoEn!)
        : '—';
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.medication_outlined),
        title: Text(prescription.nombreMedicamento,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${prescription.dosis} · ${prescription.frecuencia} · ${prescription.via.name}'),
          Text(
            prescription.duracionDias != null
                ? '${prescription.duracionDias} días — desde $dateStr'
                : 'Indefinido — desde $dateStr',
            style: const TextStyle(fontSize: 12),
          ),
        ]),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 10, height: 10,
            decoration: BoxDecoration(
              color: _estadoColor(prescription.estado), shape: BoxShape.circle)),
          if (!readOnly) ...[
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.block_outlined, size: 20),
              tooltip: 'Suspender',
              onPressed: () => ref.read(prescriptionProvider.notifier).suspend(prescription.id),
            ),
          ],
        ]),
        isThreeLine: true,
      ),
    );
  }
}
