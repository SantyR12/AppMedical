import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_model.freezed.dart';
part 'attachment_model.g.dart';

/// Tipos de archivo soportados para adjuntos (PB-13)
enum AttachmentType {
  @JsonValue('pdf') pdf,
  @JsonValue('imagen') imagen,
}

/// PB-13: Archivo adjunto a la historia clínica (PDF o imagen).
///
/// Los archivos se suben a storage y se guarda la URL de referencia.
///
/// Generar archivos con:
/// dart run build_runner build --delete-conflicting-outputs
@freezed
abstract class AttachmentModel with _$AttachmentModel {
  const factory AttachmentModel({
    required String id,
    required String historiaClinicaId,
    required String nombreArchivo,
    required AttachmentType tipo,
    /// URL del archivo en el servidor de almacenamiento
    required String url,
    int? tamanoBytes,
    String? subidoPor,
    DateTime? subidoEn,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);
}
