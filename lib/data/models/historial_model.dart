import '../../domain/entities/historial_entity.dart';
import '../../domain/entities/notificacion_entity.dart';

class HistorialModel extends HistorialEntity {
  const HistorialModel({
    required super.id,
    required super.cantidad,
    required super.tipoDispositivo,
    required super.destino,
    required super.electrodomestico,
    required super.fecha,
    required super.puntos,
    required super.estado,
  });

  factory HistorialModel.fromJson(Map<String, dynamic> json) {
    return HistorialModel(
      id: json['id'] as int,
      cantidad: json['cantidad'] as int,
      tipoDispositivo: _parseTipo(json['tipoDispositivo'] as String),
      destino: json['destino'] as String,
      electrodomestico: json['electrodomestico'] as String,
      fecha: json['fecha'] as String,
      puntos: json['puntos'] as int,
      estado: _parseEstado(json['estado'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cantidad': cantidad,
        'tipoDispositivo': tipoDispositivo.name,
        'destino': destino,
        'electrodomestico': electrodomestico,
        'fecha': fecha,
        'puntos': puntos,
        'estado': estado.name,
      };

  static TipoDispositivo _parseTipo(String value) => TipoDispositivo.values
      .firstWhere((e) => e.name == value, orElse: () => TipoDispositivo.otro);

  static EstadoSolicitud _parseEstado(String value) =>
      EstadoSolicitud.values.firstWhere((e) => e.name == value,
          orElse: () => EstadoSolicitud.enProceso);
}
