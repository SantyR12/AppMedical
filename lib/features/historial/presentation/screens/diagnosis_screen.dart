import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/diagnosis_repository.dart';
import '../../domain/models/diagnosis_model.dart';

class DiagnosisScreen extends ConsumerWidget {
  const DiagnosisScreen({
    super.key,
    required this.pacienteId,
    required this.historiaClinicaId,
  });

  final String pacienteId;
  final String historiaClinicaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagAsync = ref.watch(diagnosisProblemsProvider(pacienteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Diagnósticos')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
        onPressed: () => _showForm(context, ref),
      ),
      body: diagAsync.when(
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
                    ref.invalidate(diagnosisProblemsProvider(pacienteId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (diagnoses) {
          if (diagnoses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital_outlined,
                      size: 56,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  const Text('Sin diagnósticos activos o crónicos'),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar diagnóstico'),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: diagnoses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _DiagnosisCard(
              diagnosis: diagnoses[i],
              onEstadoChanged: (estado) async {
                try {
                  await ref
                      .read(diagnosisRepositoryProvider)
                      .updateEstado(diagnoses[i].id, estado);
                  ref.invalidate(
                      diagnosisProblemsProvider(pacienteId));
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          e.toString().replaceFirst('Exception: ', '')),
                      backgroundColor:
                          Theme.of(context).colorScheme.error,
                    ));
                  }
                }
              },
            ),
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
      builder: (_) => _DiagnosisForm(
        pacienteId: pacienteId,
        historiaClinicaId: historiaClinicaId,
        onSaved: () =>
            ref.invalidate(diagnosisProblemsProvider(pacienteId)),
      ),
    );
  }
}

// ── Tarjeta de diagnóstico ───────────────────────────────────────────────────

class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard({
    required this.diagnosis,
    required this.onEstadoChanged,
  });

  final DiagnosisModel diagnosis;
  final ValueChanged<DiagnosisEstado> onEstadoChanged;

  @override
  Widget build(BuildContext context) {
    final estadoColor = _estadoColor(diagnosis.estado);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: estadoColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: estadoColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    diagnosis.codigoCie10,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: estadoColor),
                  ),
                ),
                const SizedBox(width: 8),
                _TipoBadge(tipo: diagnosis.tipo),
                const Spacer(),
                PopupMenuButton<DiagnosisEstado>(
                  tooltip: 'Cambiar estado',
                  icon: const Icon(Icons.more_vert, size: 18),
                  onSelected: onEstadoChanged,
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: DiagnosisEstado.activo,
                      child: Text('Activo'),
                    ),
                    const PopupMenuItem(
                      value: DiagnosisEstado.cronico,
                      child: Text('Crónico'),
                    ),
                    const PopupMenuItem(
                      value: DiagnosisEstado.resuelto,
                      child: Text('Resuelto'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(diagnosis.descripcion,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            if (diagnosis.registradoPor != null) ...[
              const SizedBox(height: 4),
              Text(
                'Dr. ${diagnosis.registradoPor}${diagnosis.creadoEn != null ? ' · ${_formatDate(diagnosis.creadoEn!)}' : ''}',
                style: TextStyle(
                    fontSize: 12,
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _estadoColor(DiagnosisEstado estado) {
    switch (estado) {
      case DiagnosisEstado.activo:   return Colors.red;
      case DiagnosisEstado.cronico:  return Colors.orange;
      case DiagnosisEstado.resuelto: return Colors.green;
    }
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _TipoBadge extends StatelessWidget {
  const _TipoBadge({required this.tipo});
  final DiagnosisTipo tipo;

  @override
  Widget build(BuildContext context) {
    final label = switch (tipo) {
      DiagnosisTipo.principal   => 'Principal',
      DiagnosisTipo.secundario  => 'Secundario',
      DiagnosisTipo.presuntivo  => 'Presuntivo',
      DiagnosisTipo.definitivo  => 'Definitivo',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSecondaryContainer)),
    );
  }
}

// ── Formulario diagnóstico con búsqueda CIE-10 ──────────────────────────────

class _DiagnosisForm extends ConsumerStatefulWidget {
  const _DiagnosisForm({
    required this.pacienteId,
    required this.historiaClinicaId,
    required this.onSaved,
  });

  final String pacienteId;
  final String historiaClinicaId;
  final VoidCallback onSaved;

  @override
  ConsumerState<_DiagnosisForm> createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends ConsumerState<_DiagnosisForm> {
  final _formKey = GlobalKey<FormState>();
  final _cie10Ctrl = TextEditingController();
  Cie10Item? _selectedCie10;
  List<Cie10Item> _cie10Results = [];
  bool _cie10Loading = false;
  DiagnosisTipo _tipo = DiagnosisTipo.principal;
  DiagnosisEstado _estado = DiagnosisEstado.activo;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _cie10Ctrl.dispose();
    super.dispose();
  }

  Future<void> _searchCie10(String q) async {
    if (q.trim().length < 2) {
      setState(() => _cie10Results = []);
      return;
    }
    setState(() => _cie10Loading = true);
    try {
      final results =
          await ref.read(diagnosisRepositoryProvider).searchCie10(q);
      if (mounted) setState(() => _cie10Results = results);
    } catch (_) {
      if (mounted) setState(() => _cie10Results = []);
    } finally {
      if (mounted) setState(() => _cie10Loading = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCie10 == null) {
      setState(() => _error = 'Selecciona un código CIE-10');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(diagnosisRepositoryProvider).createDiagnosis(
            historiaClinicaId: widget.historiaClinicaId,
            pacienteId: widget.pacienteId,
            codigoCie10: _selectedCie10!.codigo,
            descripcion: _selectedCie10!.descripcion,
            tipo: _tipo,
            estado: _estado,
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
          bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  Text('Nuevo diagnóstico',
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

              // Búsqueda CIE-10
              TextFormField(
                controller: _cie10Ctrl,
                decoration: InputDecoration(
                  labelText: 'Buscar código CIE-10',
                  hintText: 'Ej: diabetes, J45, hipertensión...',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _cie10Loading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2)),
                        )
                      : null,
                ),
                onChanged: _searchCie10,
                validator: (_) => _selectedCie10 == null
                    ? 'Selecciona un diagnóstico'
                    : null,
              ),

              // Lista de resultados CIE-10
              if (_cie10Results.isNotEmpty) ...[
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _cie10Results.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final item = _cie10Results[i];
                      return ListTile(
                        dense: true,
                        title: Text(item.descripcion,
                            style: const TextStyle(fontSize: 13)),
                        trailing: Text(item.codigo,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          setState(() {
                            _selectedCie10 = item;
                            _cie10Ctrl.text = item.toString();
                            _cie10Results = [];
                          });
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
              ],

              if (_selectedCie10 != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          size: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_selectedCie10!.codigo} — ${_selectedCie10!.descripcion}',
                          style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Tipo
              DropdownButtonFormField<DiagnosisTipo>(
                value: _tipo,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                      value: DiagnosisTipo.principal,
                      child: Text('Principal')),
                  DropdownMenuItem(
                      value: DiagnosisTipo.secundario,
                      child: Text('Secundario')),
                  DropdownMenuItem(
                      value: DiagnosisTipo.presuntivo,
                      child: Text('Presuntivo')),
                  DropdownMenuItem(
                      value: DiagnosisTipo.definitivo,
                      child: Text('Definitivo')),
                ],
                onChanged: (v) => setState(() => _tipo = v!),
              ),
              const SizedBox(height: 12),

              // Estado
              DropdownButtonFormField<DiagnosisEstado>(
                value: _estado,
                decoration: const InputDecoration(
                  labelText: 'Estado inicial',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                      value: DiagnosisEstado.activo,
                      child: Text('Activo')),
                  DropdownMenuItem(
                      value: DiagnosisEstado.cronico,
                      child: Text('Crónico')),
                ],
                onChanged: (v) => setState(() => _estado = v!),
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
                    : const Text('Guardar diagnóstico'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
