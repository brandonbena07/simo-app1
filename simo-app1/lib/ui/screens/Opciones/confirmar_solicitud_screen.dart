import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/widgetsopciones/resumen_solicitud_top.dart';
import '../../widgets/widgetsopciones/simo_bottom_nav.dart';
import '../../widgets/widgetsopciones/simo_header.dart';
import '../../widgets/widgetsopciones/simo_button.dart';
import 'confirmacion_final_screen.dart';

class ConfirmarSolicitudScreen extends StatefulWidget {
  final String dispositivoLabel;
  final dynamic dispositivoIcon;
  final String destinoAliado;
  final String destinoDireccion;
  final String metodoEntrega;

  const ConfirmarSolicitudScreen({
    super.key,
    required this.dispositivoLabel,
    required this.dispositivoIcon,
    required this.destinoAliado,
    required this.destinoDireccion,
    required this.metodoEntrega,
  });

  @override
  State<ConfirmarSolicitudScreen> createState() =>
      _ConfirmarSolicitudScreenState();
}

class _ConfirmarSolicitudScreenState extends State<ConfirmarSolicitudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.simoAzul,
      appBar: SimoHeader(
        showBackButton: true,
        showLogo: false,
        puntos: 1780,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResumenSolicitudTop(
                  dispositivoLabel: widget.dispositivoLabel,
                  dispositivoIcon: widget.dispositivoIcon,
                  destinoAliado: widget.dispositivoLabel == 'Celular' ? 'EcoTech' : widget.destinoAliado,
                  destinoDireccion: widget.dispositivoLabel == 'Celular' 
                    ? 'Calle 50 #45-23, Medellin' 
                    : widget.destinoDireccion,
                  metodoEntrega: widget.metodoEntrega,
                  puntos: 1720,
                  actionText: '¿Confirmar?',
                  actionColor: const Color(0xFFD7D2CB),
                  compactAddress: true,
                  onActionPressed: null,
                ),
                const SizedBox(height: 14),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.simoCrudo,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '¿Deseas confirmar esta\nsolicitud?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Color(0xFF3F3F3F),
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: SimoButton(
                              text: 'Confirmar',
                              backgroundColor: const Color(0xFF32C68A),
                              height: 44,
                              fontSize: 13,
                              icon: Icons.check,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ConfirmacionFinalScreen(
                                      dispositivoLabel: widget.dispositivoLabel,
                                      dispositivoIcon: widget.dispositivoIcon,
                                      destinoAliado: widget.destinoAliado,
                                      destinoDireccion: widget.destinoDireccion,
                                      metodoEntrega: widget.metodoEntrega,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SimoButton(
                              text: 'Cancelar',
                              backgroundColor: const Color(0xFFED4A64),
                              height: 44,
                              fontSize: 13,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        '¡Al confirmarse la entrega de tu dispositivo, el estado\ncambiará a "Completo"!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SimoBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
      ),
    );
  }
}

class _DecisionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const _DecisionButton({
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(icon, size: 14, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}
