import '../../domain/entities/detalle_solicitud_entity.dart';
import '../../domain/entities/historial_entity.dart';
import '../../domain/entities/notificacion_entity.dart';
import '../models/detalle_solicitud_model.dart';

// Única capa que habla con el backend (GET /api/solicitudes/:id).
abstract class SolicitudRemoteDataSource {
  Future<DetalleSolicitudModel> getDetalleSolicitud(int id);
}

class SolicitudRemoteDataSourceImpl implements SolicitudRemoteDataSource {
  // TODO: inyectar Dio cuando el backend esté disponible.
  // final Dio _dio;
  // SolicitudRemoteDataSourceImpl(this._dio);

  // Mapa de datos mock por id — simula GET /api/solicitudes/:id
  static const _mockData = {
    3: DetalleSolicitudModel(
      id: 3,
      cantidad: 21,
      tipoDispositivo: TipoDispositivo.bateria,
      destino: 'Electro healt',
      direccionDestino: 'Calle 65 #15-93, Medellín',
      electrodomestico: 'Batería',
      fecha: '4 / marzo / 2026',
      puntos: 1100,
      puntosGanados: 1780,
      estado: EstadoSolicitud.completo,
      metodoEntrega: MetodoEntrega.loLlevasTu,
      nit: '0129219',
      codigo: '6645',
      fechaLimiteEntrega: '10 / Marzo / 2026',
      nota: 'Los puntos se otorgarán cuando el dispositivo sea recibido en el punto de reciclaje.',
    ),
    1: DetalleSolicitudModel(
      id: 1,
      cantidad: 1,
      tipoDispositivo: TipoDispositivo.celular,
      destino: 'Ecotech',
      direccionDestino: 'Carrera 45 #22-10, Medellín',
      electrodomestico: 'Celular',
      fecha: '4 / marzo / 2026',
      puntos: 1780,
      puntosGanados: 0,
      estado: EstadoSolicitud.enProceso,
      metodoEntrega: MetodoEntrega.loRecogemosNosotros,
      nit: '0219456',
      codigo: '4412',
      fechaLimiteEntrega: '15 / Marzo / 2026',
      nota: 'Los puntos se otorgarán cuando el dispositivo sea recibido en el punto de reciclaje.',
    ),
    2: DetalleSolicitudModel(
      id: 2,
      cantidad: 1,
      tipoDispositivo: TipoDispositivo.celular,
      destino: 'Monterrey',
      direccionDestino: 'Av. El Poblado #12-50, Medellín',
      electrodomestico: 'Celular',
      fecha: '4 / marzo / 2026',
      puntos: 1150,
      puntosGanados: 0,
      estado: EstadoSolicitud.enProceso,
      metodoEntrega: MetodoEntrega.loLlevasTu,
      nit: '0334128',
      codigo: '5231',
      fechaLimiteEntrega: '18 / Marzo / 2026',
      nota: 'Los puntos se otorgarán cuando el dispositivo sea recibido en el punto de reciclaje.',
    ),
  };

  @override
  Future<DetalleSolicitudModel> getDetalleSolicitud(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data = _mockData[id];
    if (data == null) throw Exception('Solicitud #$id no encontrada');
    return data;
  }
}
