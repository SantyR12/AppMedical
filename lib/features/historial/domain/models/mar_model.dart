enum MarResultado {
  administrado,
  omitido,
  rechazadoPaciente,
  contraindicado,
}

class MarEntryModel {
  const MarEntryModel({
    required this.id,
    required this.prescripcionId,
    required this.pacienteId,
    required this.resultado,
    required this.horaReal,
    this.horaProgramada,
    this.administradoPor,
    this.nombreMedicamento,
    this.dosisPrescrita,
    this.dosisAdministrada,
    this.viaAdministrada,
    this.observaciones,
    this.creadoEn,
  });

  final String id;
  final String prescripcionId;
  final String pacienteId;
  final MarResultado resultado;
  final DateTime horaReal;
  final DateTime? horaProgramada;
  final String? administradoPor;
  final String? nombreMedicamento;
  final String? dosisPrescrita;
  final String? dosisAdministrada;
  final String? viaAdministrada;
  final String? observaciones;
  final DateTime? creadoEn;

  factory MarEntryModel.fromJson(Map<String, dynamic> json) => MarEntryModel(
        id: json['id'] as String,
        prescripcionId: json['prescripcionId'] as String,
        pacienteId: json['pacienteId'] as String,
        resultado: _resultadoFromString(json['resultado'] as String),
        horaReal: DateTime.parse(json['horaReal'] as String),
        horaProgramada: json['horaProgramada'] != null
            ? DateTime.tryParse(json['horaProgramada'] as String)
            : null,
        administradoPor: json['administradoPor'] as String?,
        nombreMedicamento: json['nombreMedicamento'] as String?,
        dosisPrescrita: json['dosisPrescrita'] as String?,
        dosisAdministrada: json['dosisAdministrada'] as String?,
        viaAdministrada: json['viaAdministrada'] as String?,
        observaciones: json['observaciones'] as String?,
        creadoEn: json['creadoEn'] != null
            ? DateTime.tryParse(json['creadoEn'] as String)
            : null,
      );

  static MarResultado _resultadoFromString(String s) {
    switch (s) {
      case 'omitido':             return MarResultado.omitido;
      case 'rechazado_paciente':  return MarResultado.rechazadoPaciente;
      case 'contraindicado':      return MarResultado.contraindicado;
      default:                    return MarResultado.administrado;
    }
  }

  String get resultadoLabel {
    switch (resultado) {
      case MarResultado.administrado:       return 'Administrado';
      case MarResultado.omitido:            return 'Omitido';
      case MarResultado.rechazadoPaciente:  return 'Rechazado por paciente';
      case MarResultado.contraindicado:     return 'Contraindicado';
    }
  }
}
