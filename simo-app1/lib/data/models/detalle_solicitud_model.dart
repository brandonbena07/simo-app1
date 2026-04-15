import '../../domain/entities/detalle_solicitud_entity.dart';
import '../../domain/entities/notificacion_entity.dart';
import '../../domain/entities/historial_entity.dart';

class DetalleSolicitudModel extends DetalleSolicitudEntity {
  const DetalleSolicitudModel({
    required super.id,
    required super.cantidad,
    required super.tipoDispositivo,
    required super.destino,
    required super.direccionDestino,
    required super.electrodomestico,
    required super.fecha,
    required super.puntos,
    required super.puntosGanados,
    required super.estado,
    required super.metodoEntrega,
    required super.nit,
    required super.codigo,
    required super.fechaLimiteEntrega,
    required super.nota,
  });

  factory DetalleSolicitudModel.fromJson(Map<String, dynamic> json) {
    return DetalleSolicitudModel(
      id: json['id'] as int,
      cantidad: json['cantidad'] as int,
      tipoDispositivo: TipoDispositivo.values.firstWhere(
        (e) => e.name == json['tipoDispositivo'],
        orElse: () => TipoDispositivo.celular,
      ),
      destino: json['destino'] as String,
      direccionDestino: json['direccionDestino'] as String,
      electrodomestico: json['electrodomestico'] as String,
      fecha: json['fecha'] as String,
      puntos: json['puntos'] as int,
      puntosGanados: json['puntosGanados'] as int,
      estado: EstadoSolicitud.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoSolicitud.enProceso
      ),
      metodoEntrega: MetodoEntrega.values.firstWhere(
        (e) => e.name == json['metodoEntrega'],
        orElse: () => MetodoEntrega.loLlevasTu,
      ),
      nit: json['nit'] as String,
      codigo: json['codigo'] as String,
      fechaLimiteEntrega: json['fechaLimiteEntrega'] as String,
      nota: json['nota'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cantidad': cantidad,
        'tipoDispositivo': tipoDispositivo.name,
        'destino': destino,
        'direccionDestino': direccionDestino,
        'electrodomestico': electrodomestico,
        'fecha': fecha,
        'puntos': puntos,
        'puntosGanados': puntosGanados,
        'estado': estado.name,
        'metodoEntrega': metodoEntrega.name,
        'nit': nit,
        'codigo': codigo,
        'fechaLimiteEntrega': fechaLimiteEntrega,
        'nota': nota,
      };

  /// Mock para desarrollo mientras el backend no está listo
  static DetalleSolicitudModel mock() {
    return const DetalleSolicitudModel(
      id: 1,
      cantidad: 21,
      tipoDispositivo: TipoDispositivo.celular,
      destino: 'Electro healt',
      direccionDestino: 'Calle 65 #15-93, Medellín',
      electrodomestico: 'Batería',
      fecha: '4 / marzo / 2026',
      puntos: 1100,
      puntosGanados: 1780,
      estado: EstadoSolicitud.enProceso,
      metodoEntrega: MetodoEntrega.loLlevasTu,
      nit: 'NIT-0129219',
      codigo: '6645',
      fechaLimiteEntrega: '10 / Marzo / 2026',
      nota:
          'Los puntos se otorgarán cuando el dispositivo sea recibido en el punto de reciclaje.',
    );
  }
}