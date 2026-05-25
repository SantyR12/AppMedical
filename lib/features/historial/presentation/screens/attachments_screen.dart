import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/attachments_repository.dart';
import '../../domain/models/attachment_model.dart';

/// PB-13: Adjuntos clínicos del paciente (PDF, JPG, PNG — máx 10 MB).
///
/// Criterios:
/// 1. Listar adjuntos existentes del paciente
/// 2. Subir nuevo adjunto (PDF/JPG/PNG, ≤ 10 MB)
/// 3. Ver nombre, tipo, tamaño y quién lo subió
class AttachmentsScreen extends ConsumerStatefulWidget {
  const AttachmentsScreen({super.key, required this.pacienteId});

  final String pacienteId;

  @override
  ConsumerState<AttachmentsScreen> createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends ConsumerState<AttachmentsScreen> {
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: false,
      withReadStream: false,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    if (file.path == null) return;

    // Validar tamaño (10 MB)
    final sizeMb = (file.size) / (1024 * 1024);
    if (sizeMb > 10) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El archivo supera el límite de 10 MB'),
          ),
        );
      }
      return;
    }

    final mimeType = _mimeForExtension(file.extension ?? '');
    if (mimeType == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formato no permitido. Use PDF, JPG o PNG.'),
          ),
        );
      }
      return;
    }

    // Pedir descripción opcional
    String? descripcion;
    if (mounted) {
      descripcion = await _askDescripcion();
    }

    setState(() => _isUploading = true);
    try {
      await ref.read(attachmentsRepositoryProvider).uploadAttachment(
            pacienteId: widget.pacienteId,
            filePath: file.path!,
            fileName: file.name,
            mimeType: mimeType,
            descripcion: descripcion,
          );
      ref.invalidate(attachmentsProvider(widget.pacienteId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Archivo subido correctamente')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<String?> _askDescripcion() async {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Descripción del archivo'),
        content: TextField(
          controller: ctrl,
          maxLength: 150,
          decoration: const InputDecoration(
            hintText: 'Ej: Resultado laboratorio 05/2026 (opcional)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Omitir'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(context, ctrl.text.trim()),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  String? _mimeForExtension(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attachmentsAsync =
        ref.watch(attachmentsProvider(widget.pacienteId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjuntos clínicos'),
        actions: [
          if (_isUploading)
            const Padding(
              padding: EdgeInsets.all(14),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.upload_file_outlined),
              tooltip: 'Subir archivo',
              onPressed: _pickAndUpload,
            ),
        ],
      ),
      body: attachmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 12),
              Text(
                e.toString().replaceFirst('Exception: ', ''),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () =>
                    ref.invalidate(attachmentsProvider(widget.pacienteId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (attachments) {
          if (attachments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file_outlined,
                      size: 56,
                      color:
                          Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  const Text('Sin adjuntos registrados'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _isUploading ? null : _pickAndUpload,
                    icon: const Icon(Icons.upload_file_outlined),
                    label: const Text('Subir primer archivo'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: attachments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) =>
                _AttachmentCard(attachment: attachments[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isUploading ? null : _pickAndUpload,
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('Subir archivo'),
      ),
    );
  }
}

class _AttachmentCard extends StatelessWidget {
  const _AttachmentCard({required this.attachment});
  final AttachmentModel attachment;

  @override
  Widget build(BuildContext context) {
    final icon = attachment.isImage
        ? Icons.image_outlined
        : Icons.picture_as_pdf_outlined;
    final iconColor = attachment.isImage ? Colors.blue : Colors.red;

    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 32),
        title: Text(
          attachment.nombreArchivo,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (attachment.descripcion != null) ...[
              const SizedBox(height: 2),
              Text(
                attachment.descripcion!,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  attachment.tamanoLegible,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (attachment.creadoPor != null) ...[
                  const Text(' · ',
                      style: TextStyle(fontSize: 11)),
                  Expanded(
                    child: Text(
                      attachment.creadoPor!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.download_outlined, size: 20),
        onTap: () {
          // Placeholder: en producción abre la URL en el navegador o un viewer
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Descargando ${attachment.nombreArchivo}…'),
            ),
          );
        },
      ),
    );
  }
}
