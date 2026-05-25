import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router.dart';
import '../../../../features/medicamentos_alergias/presentation/widgets/allergy_banner_widget.dart';
import '../../domain/models/patient_model.dart';
import '../../providers/historial_provider.dart';

/// PB-09: Historia clínica del paciente — vista completa con secciones
/// colapsables.
class PatientDetailScreen extends ConsumerWidget {
  const PatientDetailScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historialProvider);

    ref.listen(historialProvider, (_, __) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.record == null && !state.isLoading) {
        ref.read(historialProvider.notifier).loadRecord(pacienteId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: state.record != null
            ? Text(state.record!.paciente.nombreCompleto)
            : const Text('Historia clínica'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.dashboard);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: state.record != null
                ? () => _showEditDialog(context, ref, state.record!)
                : null,
            tooltip: 'Editar historia clínica',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'archivar' && state.record != null) {
                _confirmArchive(context, ref, state.record!.id);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'archivar',
                child: Row(
                  children: [
                    Icon(Icons.archive_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Archivar historia'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, HistorialState state) {
    if (state.isLoading) return const _HistorialShimmer();

    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(state.errorMessage!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error)),
          ],
        ),
      );
    }

    if (state.record == null) {
      return const Center(child: Text('No se encontró la historia clínica'));
    }

    final record = state.record!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Banner de historia archivada
          if (record.estado == RecordStatus.archivada)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.archive_outlined,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 18),
                  const SizedBox(width: 8),
                  const Text('Historia archivada — solo lectura'),
                ],
              ),
            ),

          // PB-22: Banner prominente de alergias activas (no colapsable)
          AllergyBannerWidget(
            pacienteId: pacienteId,
            onTap: () => context.push(
              AppRoutes.allergies.replaceAll(':id', pacienteId),
            ),
          ),

          // Log de auditoría (PB-09 criterio 2)
          if (record.ultimoEditadoPor != null)
            _AuditBanner(record: record),

          const SizedBox(height: 8),

          // Secciones colapsables (PB-09 criterio 3)
          _CollapsibleSection(
            title: 'Datos personales',
            icon: Icons.person_outline,
            initiallyExpanded: true,
            child: _DatosPersonalesContent(paciente: record.paciente),
          ),
          _CollapsibleSection(
            title: 'Alergias',
            icon: Icons.warning_amber_outlined,
            badge: record.alergiasIds.length,
            child: _SectionButton(
              label: 'Ver y registrar alergias',
              icon: Icons.warning_amber_outlined,
              color: Colors.orange,
              onTap: () => context.push(
                AppRoutes.allergies.replaceAll(':id', pacienteId),
              ),
            ),
          ),
          _CollapsibleSection(
            title: 'Prescripciones',
            icon: Icons.medication_outlined,
            badge: record.medicamentosActivosIds.length,
            child: Column(
              children: [
                _SectionButton(
                  label: 'Gestionar prescripciones',
                  icon: Icons.medication_outlined,
                  color: Colors.blue,
                  onTap: () => context.push(
                    AppRoutes.prescriptions.replaceAll(':id', pacienteId),
                  ),
                ),
                const SizedBox(height: 8),
                _SectionButton(
                  label: 'Registro de administración (MAR)',
                  icon: Icons.assignment_outlined,
                  color: Colors.teal,
                  onTap: () => context.push(
                    AppRoutes.patientMar.replaceAll(':id', pacienteId),
                  ),
                ),
              ],
            ),
          ),
          _CollapsibleSection(
            title: 'Diagnósticos (CIE-10)',
            icon: Icons.local_hospital_outlined,
            badge: record.diagnosticosIds.length,
            child: _SectionButton(
              label: 'Ver y registrar diagnósticos',
              icon: Icons.local_hospital_outlined,
              color: Colors.red,
              onTap: () => context.push(
                '/patients/$pacienteId/diagnosticos?historiaId=${record.id}',
              ),
            ),
          ),
          _CollapsibleSection(
            title: 'Notas SOAP',
            icon: Icons.history_outlined,
            badge: record.consultasPreviasIds.length,
            child: _SectionButton(
              label: 'Ver y agregar notas SOAP',
              icon: Icons.description_outlined,
              color: Colors.purple,
              onTap: () => context.push(
                '/patients/$pacienteId/soap?historiaId=${record.id}',
              ),
            ),
          ),
          _CollapsibleSection(
            title: 'Adjuntos',
            icon: Icons.attach_file_outlined,
            child: _SectionButton(
              label: 'Ver y subir archivos clínicos',
              icon: Icons.attach_file_outlined,
              color: Colors.brown,
              onTap: () => context.push(
                AppRoutes.patientAdjuntos.replaceAll(':id', pacienteId),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, WidgetRef ref, ClinicalRecordModel record) {
    final p = record.paciente;
    final nombreCtrl = TextEditingController(text: p.nombreCompleto);
    final docCtrl = TextEditingController(text: p.numeroDocumento);
    final telCtrl = TextEditingController(text: p.telefono ?? '');
    final correoCtrl = TextEditingController(text: p.correo ?? '');
    final dirCtrl = TextEditingController(text: p.direccion ?? '');
    final ecNombreCtrl =
        TextEditingController(text: p.contactoEmergencia?.nombre ?? '');
    final ecTelCtrl =
        TextEditingController(text: p.contactoEmergencia?.telefono ?? '');
    var tipoDoc = p.tipoDocumento;
    var sexo = p.sexo;
    var fechaNac = p.fechaNacimiento;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Editar historia clínica'),
          scrollable: true,
          content: Form(
            key: formKey,
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Nombre completo'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<DocumentType>(
                    value: tipoDoc,
                    decoration:
                        const InputDecoration(labelText: 'Tipo de documento'),
                    items: DocumentType.values
                        .map((d) => DropdownMenuItem(
                              value: d,
                              child: Text(d.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => tipoDoc = v ?? tipoDoc),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: docCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Número de documento'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Fecha de nacimiento: '
                      '${fechaNac.day.toString().padLeft(2, '0')}/'
                      '${fechaNac.month.toString().padLeft(2, '0')}/'
                      '${fechaNac.year}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(Icons.calendar_today, size: 18),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: fechaNac,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setDialogState(() => fechaNac = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<Sex>(
                    value: sexo,
                    decoration: const InputDecoration(labelText: 'Sexo'),
                    items: Sex.values
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.name),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => sexo = v ?? sexo),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: telCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Teléfono (opcional)'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: correoCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Correo (opcional)'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: dirCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Dirección (opcional)'),
                  ),
                  const Divider(height: 24),
                  const Text('Contacto de emergencia',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: ecNombreCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Nombre'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ecTelCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Teléfono'),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(ctx);
                final ec = ecNombreCtrl.text.trim().isNotEmpty
                    ? EmergencyContact(
                        nombre: ecNombreCtrl.text.trim(),
                        telefono: ecTelCtrl.text.trim().isNotEmpty
                            ? ecTelCtrl.text.trim()
                            : null,
                      )
                    : null;
                ref.read(historialProvider.notifier).updateRecord(
                      recordId: record.id,
                      data: CreateClinicalRecordRequest(
                        nombreCompleto: nombreCtrl.text.trim(),
                        tipoDocumento: tipoDoc,
                        numeroDocumento: docCtrl.text.trim(),
                        fechaNacimiento: fechaNac,
                        sexo: sexo,
                        telefono: telCtrl.text.trim().isNotEmpty
                            ? telCtrl.text.trim()
                            : null,
                        correo: correoCtrl.text.trim().isNotEmpty
                            ? correoCtrl.text.trim()
                            : null,
                        direccion: dirCtrl.text.trim().isNotEmpty
                            ? dirCtrl.text.trim()
                            : null,
                        contactoEmergencia: ec,
                      ),
                    );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmArchive(
      BuildContext context, WidgetRef ref, String recordId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Archivar historia clínica'),
        content: const Text(
            'La historia quedará archivada y en modo solo lectura. ¿Confirmas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ref.read(historialProvider.notifier).archiveRecord(recordId);
            },
            child: const Text('Archivar'),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// WIDGETS INTERNOS
// =============================================================================

class _AuditBanner extends StatelessWidget {
  const _AuditBanner({required this.record});
  final ClinicalRecordModel record;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.history,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Última edición por ${record.ultimoEditadoPor}'
              '${record.ultimoEditadoDesde != null ? ' desde ${record.ultimoEditadoDesde}' : ''}'
              '${record.ultimaEdicionEn != null ? ' · ${_formatDate(record.ultimaEdicionEn!)}' : ''}',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _CollapsibleSection extends StatelessWidget {
  const _CollapsibleSection({
    required this.title,
    required this.icon,
    required this.child,
    this.badge = 0,
    this.initiallyExpanded = false,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final int badge;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(icon,
            color: Theme.of(context).colorScheme.primary, size: 22),
        title: Row(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            if (badge > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
        initiallyExpanded: initiallyExpanded,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [child],
      ),
    );
  }
}

class _DatosPersonalesContent extends StatelessWidget {
  const _DatosPersonalesContent({required this.paciente});
  final PatientModel paciente;

  @override
  Widget build(BuildContext context) {
    final edad = _calcularEdad(paciente.fechaNacimiento);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow('Nombre', paciente.nombreCompleto),
        _InfoRow(
            'Documento',
            '${paciente.tipoDocumento.name.toUpperCase()} '
            '${paciente.numeroDocumento}'),
        _InfoRow('Fecha de nacimiento',
            _formatDate(paciente.fechaNacimiento)),
        _InfoRow('Edad', '$edad años'),
        _InfoRow('Sexo', paciente.sexo.name),
        if (paciente.telefono != null)
          _InfoRow('Teléfono', paciente.telefono!),
        if (paciente.correo != null)
          _InfoRow('Correo', paciente.correo!),
        if (paciente.direccion != null)
          _InfoRow('Dirección', paciente.direccion!),
        if (paciente.contactoEmergencia?.nombre != null) ...[
          const Divider(height: 20),
          const Text('Contacto de emergencia',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          _InfoRow('Nombre', paciente.contactoEmergencia!.nombre!),
          if (paciente.contactoEmergencia!.telefono != null)
            _InfoRow(
                'Teléfono', paciente.contactoEmergencia!.telefono!),
        ],
      ],
    );
  }

  int _calcularEdad(DateTime fechaNacimiento) {
    final hoy = DateTime.now();
    int edad = hoy.year - fechaNacimiento.year;
    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month &&
            hoy.day < fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
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

class _SectionButton extends StatelessWidget {
  const _SectionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: color),
      label: Text(label, style: TextStyle(color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withValues(alpha: 0.4)),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }
}

class _HistorialShimmer extends StatefulWidget {
  const _HistorialShimmer();

  @override
  State<_HistorialShimmer> createState() => _HistorialShimmerState();
}

class _HistorialShimmerState extends State<_HistorialShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(
            5,
            (i) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: _animation.value),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
