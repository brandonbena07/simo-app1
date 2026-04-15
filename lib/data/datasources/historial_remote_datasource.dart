import '../../domain/entities/historial_entity.dart';
import '../../domain/entities/notificacion_entity.dart';
import '../models/historial_model.dart';

// Única capa que habla con el backend (o datos mock durante desarrollo).
abstract class HistorialRemoteDataSource {
  Future<List<HistorialModel>> getHistorial();
}

class HistorialRemoteDataSourceImpl implements HistorialRemoteDataSource {
  // TODO: inyectar Dio cuando el backend esté disponible.
  // final Dio _dio;
  // HistorialRemoteDataSourceImpl(this._dio);

  @override
  Future<List<HistorialModel>> getHistorial() async {
    // Datos mock que replican la respuesta del endpoint GET /api/solicitudes
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      const HistorialModel(
        id: 1,
        cantidad: 1,
        tipoDispositivo: TipoDispositivo.celular,
        destino: 'Ecotech',
        electrodomestico: 'Celular',
        fecha: '4/3/2026',
        puntos: 1780,
        estado: EstadoSolicitud.enProceso,
      ),
      const HistorialModel(
        id: 2,
        cantidad: 1,
        tipoDispositivo: TipoDispositivo.celular,
        destino: 'Monterrey',
        electrodomestico: 'Celular',
        fecha: '4/3/2026',
        puntos: 1150,
        estado: EstadoSolicitud.enProceso,
      ),
      const HistorialModel(
        id: 3,
        cantidad: 21,
        tipoDispositivo: TipoDispositivo.bateria,
        destino: 'Electro healt',
        electrodomestico: 'Baterias',
        fecha: '3/2/2026',
        puntos: 1100,
        estado: EstadoSolicitud.completo,
      ),
    ];
  }
}
