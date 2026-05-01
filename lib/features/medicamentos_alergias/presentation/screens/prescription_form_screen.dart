import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:sgp_app/shared/widgets/sgp_text_field.dart';
import 'package:sgp_app/features/medicamentos_alergias/data/repositories/prescription_repository.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/models/allergy_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/domain/models/prescription_model.dart';
import 'package:sgp_app/features/medicamentos_alergias/providers/allergy_provider.dart';

/// PB-15 · Generación de prescripciones digitales.
///
/// Criterios implementados:
/// 1. Campos: medicamento (autocompletado), dosis+unidad, frecuencia,
///    vía de administración, duración, indicaciones especiales
/// 2. Alerta de duplicidad si el medicamento ya está activo para el paciente
/// 3. Alerta de seguridad si hay alergia activa al medicamento
/// 4. Validación de dosis (la valida el backend con peso y edad)
/// 5. Prescripción firmada digitalmente (nombre médico, matrícula, fecha/hora)
class PrescriptionFormScreen extends ConsumerStatefulWidget {
  const PrescriptionFormScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  ConsumerState<PrescriptionFormScreen> createState() =>
      _PrescriptionFormScreenState();
}

class _PrescriptionFormScreenState
    extends ConsumerState<PrescriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medController = TextEditingController();
  final _dosisController = TextEditingController();
  final _duracionController = TextEditingController();
  final _indicacionesController = TextEditingController();

  String? _medicamentoId;
  DoseUnit _dosisUnidad = DoseUnit.mg;
  int _frecuenciaHoras = 8;
  AdministrationRoute _via = AdministrationRoute.oral;

  bool _isChecking = false;
  bool _isSaving = false;

  // Alertas
  DuplicityAlert? _duplicityAlert;
  AllergyAlert? _allergyAlert;
  String? _errorMessage;

  @override
  void dispose() {
    _medController.dispose();
    _dosisController.dispose();
    _duracionController.dispose();
    _indicacionesController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Al seleccionar un medicamento, verificar duplicidad y alergia
  // -------------------------------------------------------------------------
  Future<void> _onMedicamentoSelected(MedicationModel med) async {
    _medController.text = med.nombreGenerico;
    setState(() {
      _medicamentoId = med.id;
      _duplicityAlert = null;
      _allergyAlert = null;
      _isChecking = true;
    });

    final repo = ref.read(prescriptionRepositoryProvider);

    try {
      final results = await Future.wait([
        repo.checkDuplicity(
          pacienteId: widget.pacienteId,
          medicamentoId: med.id,
        ),
        repo.checkAllergyAlert(
          pacienteId: widget.pacienteId,
          medicamentoId: med.id,
        ),
      ]);

      setState(() {
        _duplicityAlert = results[0] as DuplicityAlert;
        _allergyAlert = results[1] as AllergyAlert;
        _isChecking = false;
      });
    } catch (_) {
      setState(() => _isChecking = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_medicamentoId == null) {
      setState(() =>
          _errorMessage = 'Selecciona un medicamento de la lista');
      return;
    }

    // Si hay alergia grave, mostrar diálogo de confirmación (PB-15 criterio 3)
    if (_allergyAlert?.hasAllergy == true) {
      final confirm = await _showAllergyConfirmDialog();
      if (!confirm) return;
    }

    // Si hay duplicidad, mostrar diálogo de confirmación (PB-15 criterio 2)
    if (_duplicityAlert?.hasDuplicity == true) {
      final confirm = await _showDuplicityConfirmDialog();
      if (!confirm) return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final request = CreatePrescriptionRequest(
        pacienteId: widget.pacienteId,
        medicamentoId: _medicamentoId!,
        medicamentoNombre: _medController.text.trim(),
        dosis: double.parse(_dosisController.text.trim()),
        dosisUnidad: _dosisUnidad,
        frecuenciaHoras: _frecuenciaHoras,
        viaAdministracion: _via,
        duracionDias: int.parse(_duracionController.text.trim()),
        indicacionesEspeciales: _indicacionesController.text.trim().isEmpty
            ? null
            : _indicacionesController.text.trim(),
      );

      await ref.read(prescriptionRepositoryProvider).createPrescription(request);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prescripción generada y firmada correctamente'),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<bool> _showAllergyConfirmDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning_rounded,
                    color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 8),
                const Text('Alerta de alergia'),
              ],
            ),
            content: Text(
              'Este paciente tiene una alergia activa a '
              '${_allergyAlert!.agenteCausante ?? 'este medicamento'} '
              '(${_allergyAlert!.severidad ?? 'severidad desconocida'}). '
              '¿Confirmas que deseas prescribir de todas formas?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Confirmar de todas formas'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _showDuplicityConfirmDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('Medicamento duplicado'),
              ],
            ),
            content: const Text(
              'El paciente ya tiene una prescripción activa para este medicamento. '
              '¿Deseas generar una prescripción adicional?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva prescripción'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── MEDICAMENTO con autocompletado ────────────────────────
                _Label('Medicamento *'),
                TypeAheadField<MedicationModel>(
                  controller: _medController,
                  suggestionsCallback: (query) async {
                    if (query.length < 2) return [];
                    return ref
                        .read(medicationSuggestionsProvider(query).future);
                  },
                  itemBuilder: (context, med) => ListTile(
                    title: Text(med.nombreGenerico),
                    subtitle: med.nombreComercial != null
                        ? Text(med.nombreComercial!)
                        : null,
                    dense: true,
                  ),
                  onSelected: _onMedicamentoSelected,
                  builder: (context, controller, focusNode) =>
                      TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Nombre genérico o comercial...',
                      prefixIcon: Icon(Icons.medication_outlined),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Selecciona un medicamento'
                        : null,
                  ),
                  emptyBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Sin resultados'),
                  ),
                ),
                const SizedBox(height: 8),

                // Indicador de verificación
                if (_isChecking)
                  const LinearProgressIndicator(),

                // Alerta de alergia (PB-15 criterio 3) — rojo
                if (_allergyAlert?.hasAllergy == true) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.error),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ALERTA: Este paciente tiene alergia activa a '
                            '${_allergyAlert!.agenteCausante ?? 'este medicamento'} '
                            '— Severidad: ${_allergyAlert!.severidad ?? 'desconocida'}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Alerta de duplicidad (PB-15 criterio 2) — naranja
                if (_duplicityAlert?.hasDuplicity == true) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade400),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Colors.orange.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Atención: ya existe una prescripción activa '
                            'para ${_duplicityAlert!.medicamentoNombre ?? 'este medicamento'}.',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const FormGap(height: 16),

                // ── DOSIS + UNIDAD ────────────────────────────────────────
                _Label('Dosis *'),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _dosisController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Ej: 500',
                          labelText: 'Cantidad',
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Requerido';
                          }
                          if (double.tryParse(v.trim()) == null ||
                              double.parse(v.trim()) <= 0) {
                            return 'Dosis inválida';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<DoseUnit>(
                        value: _dosisUnidad,
                        items: DoseUnit.values
                            .map((u) => DropdownMenuItem(
                                value: u, child: Text(u.name)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _dosisUnidad = v!),
                        decoration:
                            const InputDecoration(labelText: 'Unidad'),
                      ),
                    ),
                  ],
                ),
                const FormGap(height: 14),

                // ── FRECUENCIA ────────────────────────────────────────────
                _Label('Frecuencia *'),
                DropdownButtonFormField<int>(
                  value: _frecuenciaHoras,
                  items: [4, 6, 8, 12, 24, 48]
                      .map((h) => DropdownMenuItem(
                          value: h,
                          child: Text(
                              'Cada $h horas${h == 24 ? ' (1 vez al día)' : h == 48 ? ' (cada 2 días)' : ''}')))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _frecuenciaHoras = v!),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.schedule_outlined),
                  ),
                ),
                const FormGap(height: 14),

                // ── VÍA DE ADMINISTRACIÓN ─────────────────────────────────
                _Label('Vía de administración *'),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: AdministrationRoute.values.map((v) {
                    final isSelected = _via == v;
                    return ChoiceChip(
                      label: Text(_labelVia(v)),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _via = v),
                      selectedColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    );
                  }).toList(),
                ),
                const FormGap(height: 14),

                // ── DURACIÓN ──────────────────────────────────────────────
                SgpTextField(
                  label: 'Duración del tratamiento (días) *',
                  hint: 'Ej: 7',
                  controller: _duracionController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'La duración es obligatoria';
                    }
                    final n = int.tryParse(v.trim());
                    if (n == null || n <= 0) return 'Duración inválida';
                    return null;
                  },
                ),
                const FormGap(height: 14),

                // ── INDICACIONES ESPECIALES ───────────────────────────────
                SgpTextField(
                  label: 'Indicaciones especiales',
                  hint: 'Tomar con alimentos, evitar alcohol...',
                  controller: _indicacionesController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 300,
                ),
                const FormGap(height: 24),

                // Error
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onErrorContainer),
                    ),
                  ),
                  const FormGap(),
                ],

                ElevatedButton.icon(
                  onPressed: _isSaving ? null : _submit,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.draw_outlined, size: 18),
                  label: const Text('Generar y firmar prescripción'),
                ),
                const FormGap(),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelVia(AdministrationRoute v) {
    switch (v) {
      case AdministrationRoute.oral:
        return 'Oral';
      case AdministrationRoute.iv:
        return 'IV';
      case AdministrationRoute.im:
        return 'IM';
      case AdministrationRoute.subcutanea:
        return 'Subcutánea';
      case AdministrationRoute.topica:
        return 'Tópica';
    }
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )),
      );
}
