import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/datasources/historial_remote_datasource.dart';
import '../../data/datasources/notificacion_remote_datasource.dart';
import '../../data/datasources/solicitud_remote_datasource.dart';
import '../../data/repositories/historial_repository_impl.dart';
import '../../data/repositories/notificacion_repository_impl.dart';
import '../../data/repositories/solicitud_repository_impl.dart';
import '../../domain/usecases/get_historial_usecase.dart';
import '../../domain/usecases/get_notificaciones_usecase.dart';
import '../../domain/usecases/get_detalle_solicitud_usecase.dart';
import '../providers/historial_notifier.dart';
import '../providers/notificacion_notifier.dart';
import '../providers/detalle_solicitud_notifier.dart';
import '../widgets/historial_card.dart';
import '../widgets/notificacion_card.dart';
import 'detalle_solicitud_screen.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  // ─── Colores SIMÖ ─────────────────────────────────────────────────────────────
  static const _amarillo = Color(0xFFFECD20);
  static const _azul = Color(0xFF2D4EA2);
  static const _crudo = Color(0xFFFFFCE7);
  static const _textoDark = Color(0xFF1E272E);

  int _tabIndex = 0; // 0 = Notificación | 1 = Historial

  late final NotificacionNotifier _notifier;
  late final HistorialNotifier _historialNotifier;

  @override
  void initState() {
    super.initState();
    _notifier = NotificacionNotifier(
      GetNotificacionesUseCase(NotificacionRepositoryImpl(NotificacionRemoteDataSourceImpl())),
    );
    _notifier.addListener(_onStateChange);
    _notifier.cargarNotificaciones();

    _historialNotifier = HistorialNotifier(
      GetHistorialUseCase(HistorialRepositoryImpl(HistorialRemoteDataSourceImpl())),
    );
    _historialNotifier.addListener(_onStateChange);
  }

  void _onStateChange() => setState(() {});

  @override
  void dispose() {
    _notifier.removeListener(_onStateChange);
    _notifier.dispose();
    _historialNotifier.removeListener(_onStateChange);
    _historialNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _azul, // Color de fondo principal es Azul
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 25),
                  _buildTabs(),
                  const SizedBox(height: 15),
                  if (_tabIndex == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Oprime para ver mas a detalle...',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: _tabIndex == 0
                        ? _buildNotificacionesList(_notifier.state)
                        : _buildHistorialList(_historialNotifier.state),
                  ),
              ],
            ),
          ),
          _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(16, topPad + 16, 16, 24),
      decoration: const BoxDecoration(
        color: _crudo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back_ios_new, size: 36, color: _textoDark),
          ),
          const Spacer(),
          // Badge Puntos
          Transform.translate(
            offset: const Offset(0, -4),
            child: Row(
              children: [
                Image.asset('assets/icons/flor.png', width: 26, height: 26),
                const SizedBox(width: 8),
                Text(
                  '1100',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: _azul,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Campana
          Image.asset('assets/icons/notificacion.png', width: 42, height: 42),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          Expanded(child: _TabButton(label: 'Notificación', selected: _tabIndex == 0, onTap: () => setState(() => _tabIndex = 0))),
          const SizedBox(width: 16),
          Expanded(
              child: _TabButton(
                  label: 'Historial',
                  selected: _tabIndex == 1,
                  onTap: () {
                    setState(() => _tabIndex = 1);
                    if (_historialNotifier.state.historial.isEmpty && !_historialNotifier.state.isLoading) {
                      _historialNotifier.cargarHistorial();
                    }
                  })),
        ],
      ),
    );
  }

  Widget _buildNotificacionesList(NotificacionState state) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator(color: _amarillo));
    if (state.errorMessage != null) return _ErrorView(message: state.errorMessage!, onRetry: _notifier.cargarNotificaciones);
    if (state.notificaciones.isEmpty) return Center(child: Text('No hay notificaciones', style: GoogleFonts.plusJakartaSans(color: Colors.white70)));

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: state.notificaciones.length,
      itemBuilder: (context, index) => NotificacionCard(notificacion: state.notificaciones[index]),
    );
  }

  Widget _buildHistorialList(HistorialState state) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator(color: _amarillo));
    if (state.errorMessage != null) return _ErrorView(message: state.errorMessage!, onRetry: _historialNotifier.cargarHistorial);
    if (state.historial.isEmpty) return Center(child: Text('No hay historial aún', style: GoogleFonts.plusJakartaSans(color: Colors.white70)));

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: state.historial.length,
      itemBuilder: (context, index) {
        final item = state.historial[index];
        return HistorialCard(
          item: item,
          onTap: () {
            final useCase = GetDetalleSolicitudUseCase(SolicitudRepositoryImpl(SolicitudRemoteDataSourceImpl()));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => DetalleSolicitudNotifier(useCase),
                  child: DetalleSolicitudScreen(solicitudId: item.id),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final botPad = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 20, 16, botPad + 12),
      decoration: const BoxDecoration(
        color: _crudo,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: 'assets/icons/Inicio_icono.png', label: 'Inicio', active: false),
          _NavItem(icon: 'assets/icons/opciones_icono.png', label: 'Opciones', active: false),
          _NavItem(icon: 'assets/icons/Canjear_icono.png', label: 'Canjear', active: false),
          _NavItem(icon: 'assets/icons/usuario_icono.png', label: 'Usuario', active: true),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFECD20) : const Color(0xFFFFFCE7),
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF1E272E),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;

  const _NavItem({required this.icon, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: 36, height: 36),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: active ? FontWeight.bold : FontWeight.w600,
            color: const Color(0xFF1E272E),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 52),
          const SizedBox(height: 14),
          Text(message, style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16)),
          TextButton(onPressed: onRetry, child: const Text('Reintentar', style: TextStyle(color: Color(0xFFFECD20), fontSize: 16))),
        ],
      ),
    );
  }
}
