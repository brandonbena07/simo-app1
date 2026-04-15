import 'package:flutter/material.dart';
import 'opciones_screen.dart';

import '../theme/app_colors.dart';
import '../widgets/resumen_solicitud_top.dart';
import '../widgets/simo_bottom_nav.dart';
import '../widgets/simo_button.dart';
import '../widgets/simo_header.dart';

class ConfirmacionFinalScreen extends StatefulWidget {
  final String dispositivoLabel;
  final dynamic dispositivoIcon;
  final String destinoAliado;
  final String destinoDireccion;
  final String metodoEntrega;

  const ConfirmacionFinalScreen({
    super.key,
    required this.dispositivoLabel,
    required this.dispositivoIcon,
    required this.destinoAliado,
    required this.destinoDireccion,
    required this.metodoEntrega,
  });

  @override
  State<ConfirmacionFinalScreen> createState() => _ConfirmacionFinalScreenState();
}

class _ConfirmacionFinalScreenState extends State<ConfirmacionFinalScreen> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.simoAzul,
      appBar: SimoHeader(
        showBackButton: true,
        showLogo: false,
        puntos: 1780,
        onBackPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OpcionesScreen()),
            (route) => false,
          );
        },
      ),
      body: SafeArea(
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
                actionText: 'Confirmado',
                actionColor: const Color(0xFF38C878),
                actionTextColor: Colors.white,
                actionIcon: Icons.check,
                compactAddress: true,
                onActionPressed: null,
              ),
              const SizedBox(height: 12),
              const Text(
                'Confirmación',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.simoCrudo,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Icon(
                            _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, 
                            color: AppColors.simoAzul, 
                            size: 24
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '4 / marzo / 2026 - NIT:0129219',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              'Detalles de la solicitud',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '¡Solicitud aceptada!',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF303030),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.simoAzul,
                                fontWeight: FontWeight.w900,
                              ),
                              children: [
                                TextSpan(text: 'CODE: '),
                                TextSpan(
                                  text: '2345',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _infoRow('Dispositivo:', widget.dispositivoLabel),
                      const SizedBox(height: 2),
                      _infoRow('Fecha límite de entrega:', '10 / Marzo / 2026'),
                      const SizedBox(height: 2),
                      _infoRow('Puntos verdes ganados:', '1780 puntos'),
                      const SizedBox(height: 10),
                      const Text(
                        'NOTA: Los puntos se otorgarán cuando el\ndispositivo sea recibido en el punto de reciclaje\ny la empresa registre el Codigo.',
                        style: TextStyle(
                          fontSize: 8.5,
                          color: Color(0xFF6E6E6E),
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SimoButton(
                          text: 'Cancelar solicitud',
                          backgroundColor: const Color(0xFFED4A64),
                          height: 30,
                          horizontalPadding: 14,
                          fontSize: 10,
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
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

  static Widget _infoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF3F3F3F),
          fontWeight: FontWeight.w800,
          height: 1.2,
        ),
        children: [
          TextSpan(text: '$label '),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.simoAzul,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
