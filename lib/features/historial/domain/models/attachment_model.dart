/// PB-13: Adjunto clínico (PDF, imagen) vinculado a la historia del paciente.
class AttachmentModel {
  const AttachmentModel({
    required this.id,
    required this.pacienteId,
    required this.nombreArchivo,
    required this.tipoMime,
    required this.tamanoBytes,
    required this.urlDescarga,
    this.descripcion,
    this.creadoPor,
    this.creadoEn,
  });

  final String id;
  final String pacienteId;
  final String nombreArchivo;
  final String tipoMime;
  final int tamanoBytes;
  final String urlDescarga;
  final String? descripcion;
  final String? creadoPor;
  final DateTime? creadoEn;

  bool get isImage => tipoMime.startsWith('image/');

  String get tamanoLegible {
    if (tamanoBytes < 1024) return '$tamanoBytes B';
    if (tamanoBytes < 1024 * 1024) {
      return '${(tamanoBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(tamanoBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] as String,
      pacienteId: json['pacienteId'] as String,
      nombreArchivo: json['nombreArchivo'] as String,
      tipoMime: json['tipoMime'] as String,
      tamanoBytes: (json['tamanoBytes'] as num).toInt(),
      urlDescarga: json['urlDescarga'] as String,
      descripcion: json['descripcion'] as String?,
      creadoPor: json['creadoPor'] as String?,
      creadoEn: json['creadoEn'] != null
          ? DateTime.tryParse(json['creadoEn'].toString())
          : null,
    );
  }
}
