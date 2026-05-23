import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/diagnosis_repository.dart';
import '../../domain/models/diagnosis_model.dart';
import '../../providers/diagnosis_provider.dart';

class DiagnosisFormScreen extends ConsumerStatefulWidget {
  const DiagnosisFormScreen({
    super.key,
    required this.historiaClinicaId,
    required this.pacienteId,
  });
  final String historiaClinicaId;
  final String pacienteId;

  @override
  ConsumerState<DiagnosisFormScreen> createState() => _DiagnosisFormScreenState();
}

class _DiagnosisFormScreenState extends ConsumerState<DiagnosisFormScreen> {
  final _searchCtrl = TextEditingController();
  Cie10Item? _selectedCie10;
  TipoDiagnostico _tipo = TipoDiagnostico.presuntivo;
  EstadoDiagnostico _estado = EstadoDiagnostico.activo;
  List<Cie10Item> _suggestions = [];
  bool _searching = false;
  bool _saving = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _searchCie10(String query) async {
    if (query.length < 2) { setState(() => _suggestions = []); return; }
    setState(() => _searching = true);
    try {
      final results = await ref.read(diagnosisRepositoryProvider).searchCie10(query);
      setState(() => _suggestions = results);
    } finally {
      setState(() => _searching = false);
    }
  }

  Future<void> _save() async {
    if (_selectedCie10 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un código CIE-10')));
      return;
    }
    setState(() => _saving = true);
    final success = await ref.read(diagnosisProvider.notifier).create(
      CreateDiagnosisRequest(
        historiaClinicaId: widget.historiaClinicaId,
        pacienteId: widget.pacienteId,
        codigoCie10: _selectedCie10!.codigo,
        descripcion: _selectedCie10!.descripcion,
        tipo: _tipo,
        estado: _estado,
      ),
    );
    setState(() => _saving = false);
    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diagnóstico registrado')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo diagnóstico'),
        actions: [
          if (_saving)
            const Padding(padding: EdgeInsets.all(16),
              child: SizedBox(width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2)))
          else
            TextButton(onPressed: _save, child: const Text('Guardar')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Código CIE-10', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Buscar diagnóstico o código (ej: J45, Asma...)',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: _searching
                ? const Padding(padding: EdgeInsets.all(12),
                    child: SizedBox(width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2)))
                : null,
            ),
            onChanged: _searchCie10,
          ),
          if (_selectedCie10 != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(
                    '${_selectedCie10!.codigo} — ${_selectedCie10!.descripcion}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => setState(() => _selectedCie10 = null),
                  ),
                ],
              ),
            ),
          if (_suggestions.isNotEmpty && _selectedCie10 == null)
            Card(
              child: Column(
                children: _suggestions.map((item) => ListTile(
                  dense: true,
                  title: Text(item.descripcion, style: const TextStyle(fontSize: 13)),
                  subtitle: Text(item.codigo,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  onTap: () => setState(() {
                    _selectedCie10 = item;
                    _suggestions = [];
                    _searchCtrl.text = '${item.codigo} — ${item.descripcion}';
                  }),
                )).toList(),
              ),
            ),
          const SizedBox(height: 20),
          const Text('Tipo', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: TipoDiagnostico.values.map((t) =>
            ChoiceChip(label: Text(t.name), selected: _tipo == t,
              onSelected: (_) => setState(() => _tipo = t))).toList()),
          const SizedBox(height: 20),
          const Text('Estado', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: EstadoDiagnostico.values.map((e) =>
            ChoiceChip(label: Text(e.name), selected: _estado == e,
              onSelected: (_) => setState(() => _estado = e))).toList()),
        ],
      ),
    );
  }
}
