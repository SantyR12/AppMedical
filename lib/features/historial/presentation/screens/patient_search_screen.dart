import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/patient_model.dart';
import '../../providers/historial_provider.dart';

/// PB-14: Pantalla de búsqueda de pacientes.
///
/// Criterios implementados:
/// 1. Se activa automáticamente al escribir mínimo 3 caracteres
/// 2. Búsqueda por nombre (parcial, sin mayúsculas) o número de documento
/// 3. Resultados muestran: nombre, tipo/número documento, edad, último médico
/// 4. Mensaje "No se encontraron pacientes" si no hay resultados
/// 5. Tiempo de respuesta < 1 segundo con hasta 1000 pacientes (backend)
class PatientSearchScreen extends ConsumerStatefulWidget {
  const PatientSearchScreen({super.key});

  @override
  ConsumerState<PatientSearchScreen> createState() =>
      _PatientSearchScreenState();
}

class _PatientSearchScreenState extends ConsumerState<PatientSearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(patientSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar paciente'),
        actions: [
          // Nuevo paciente — solo médicos y admins (el router lo valida)
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            tooltip: 'Nuevo paciente',
            onPressed: () {
              // TODO: navegar a NewPatientScreen (PB-10) en días siguientes
            },
          ),
        ],
        // Campo de búsqueda en el AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Nombre, número de documento...',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(patientSearchProvider.notifier).clear();
                    },
                  ),
              ],
              onChanged: (query) {
                // Busca automáticamente al escribir ≥ 3 chars (PB-14 criterio 1)
                ref.read(patientSearchProvider.notifier).search(query);
              },
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(context, searchState),
    );
  }

  Widget _buildBody(BuildContext context, PatientSearchState state) {
    // Estado inicial — sin búsqueda
    if (!state.hasSearched && !state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search,
                size: 64,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              'Escribe al menos 3 caracteres\npara buscar un paciente',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Loading
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error
    if (state.hasError) {
      return Center(
        child: Text(
          state.errorMessage!,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }

    // Sin resultados (PB-14 criterio 4)
    if (state.results.isEmpty && state.hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search,
                size: 64,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron pacientes con ese criterio',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Lista de resultados (PB-14 criterio 3)
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final patient = state.results[index];
        return _PatientCard(patient: patient);
      },
    );
  }
}

class _PatientCard extends StatelessWidget {
  const _PatientCard({required this.patient});
  final PatientModel patient;

  int get _edad {
    final hoy = DateTime.now();
    int edad = hoy.year - patient.fechaNacimiento.year;
    if (hoy.month < patient.fechaNacimiento.month ||
        (hoy.month == patient.fechaNacimiento.month &&
            hoy.day < patient.fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            patient.nombreCompleto.isNotEmpty
                ? patient.nombreCompleto[0].toUpperCase()
                : '?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Nombre completo
        title: Text(
          patient.nombreCompleto,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        // Tipo doc, número, edad (PB-14 criterio 3)
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              '${patient.tipoDocumento.name.toUpperCase()} ${patient.numeroDocumento} · $_edad años',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (patient.ultimoMedicoTratante != null)
              Text(
                'Médico: ${patient.ultimoMedicoTratante}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: navegar a PatientDetailScreen con el ID del paciente
          // context.push('/patients/${patient.id}');
        },
      ),
    );
  }
}