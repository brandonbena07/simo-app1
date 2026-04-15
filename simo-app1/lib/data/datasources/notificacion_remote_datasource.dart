import '../../domain/entities/notificacion_entity.dart';
import '../models/notificacion_model.dart';

// Única capa que habla con el backend (o datos mock durante desarrollo).
abstract class NotificacionRemoteDataSource {
  Future<List<NotificacionModel>> getNotificaciones();
}

class NotificacionRemoteDataSourceImpl implements NotificacionRemoteDataSource {
  // TODO: inyectar Dio cuando el backend esté disponible.
  // final Dio _dio;
  // NotificacionRemoteDataSourceImpl(this._dio);

  @override
  Future<List<NotificacionModel>> getNotificaciones() async {
    // Datos mock que replican la respuesta del endpoint GET /api/notificaciones
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      const NotificacionModel(
        id: 1,
        titulo: 'EcoTech Aceptó tu solicitud',
        descripcion:
            'Tu reciclaje fue aceptado por el punto seleccionado.',
        fecha: '4/3/2026',
        cantidad: 1,
        tipoDispositivo: TipoDispositivo.celular,
        estado: EstadoNotificacion.aceptada,
      ),
      const NotificacionModel(
        id: 2,
        titulo: 'Monterrey En camino',
        descripcion: 'El recolector va camino a tu ubicación.',
        fecha: '4/3/2026',
        cantidad: 1,
        tipoDispositivo: TipoDispositivo.celular,
        estado: EstadoNotificacion.enCamino,
      ),
      const NotificacionModel(
        id: 3,
        titulo: 'Electro healt Entrega registrada',
        descripcion:
            'El punto de reciclaje confirmó la recepción de tu dispositivo. Ahora se le acumularon los puntos.',
        fecha: '3/2/2026',
        cantidad: 21,
        tipoDispositivo: TipoDispositivo.bateria,
        estado: EstadoNotificacion.entregada,
      ),
      const NotificacionModel(
        id: 4,
        titulo: 'Solicitud cancelada',
        descripcion:
            'Tu solicitud a machine tecno fue cancelada. Puedes crear una nueva cuando lo desees.',
        fecha: '1/13/2026',
        cantidad: 1,
        tipoDispositivo: TipoDispositivo.tablet,
        estado: EstadoNotificacion.cancelada,
      ),
    ];
  }
}
