import '../../domain/entities/notificacion_entity.dart';

class NotificacionModel extends NotificacionEntity {
  const NotificacionModel({
    required super.id,
    required super.titulo,
    required super.descripcion,
    required super.fecha,
    required super.cantidad,
    required super.tipoDispositivo,
    required super.estado,
  });

  factory NotificacionModel.fromJson(Map<String, dynamic> json) {
    return NotificacionModel(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      fecha: json['fecha'] as String,
      cantidad: json['cantidad'] as int,
      tipoDispositivo: _parseTipoDispositivo(json['tipoDispositivo'] as String),
      estado: _parseEstado(json['estado'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descripcion': descripcion,
        'fecha': fecha,
        'cantidad': cantidad,
        'tipoDispositivo': tipoDispositivo.name,
        'estado': estado.name,
      };

  static TipoDispositivo _parseTipoDispositivo(String value) {
    return TipoDispositivo.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TipoDispositivo.otro,
    );
  }

  static EstadoNotificacion _parseEstado(String value) {
    return EstadoNotificacion.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EstadoNotificacion.aceptada,
    );
  }
}
