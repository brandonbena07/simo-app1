import 'package:flutter/material.dart';

const Color simoMagenta = Color(0xFFD8006B);
const Color simoAmarillo = Color(0xFFF5B800);
const Color simoAzul = Color(0xFF2D4EA2);
const Color simoCrudo = Color(0xFFF7F4EC);
const Color simoVerde = Color(0xFF3AAA35);
const Color simoRojo = Color(0xFFE8003D);
const Color textoOscuro = Color(0xFF333333);

class UsuarioMenuScreen extends StatelessWidget {
  const UsuarioMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: simoMagenta,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              decoration: const BoxDecoration(
                color: simoCrudo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/imagenes/usuario/simo.png', height: 45),
                  Row(
                    children: [
                      Image.asset(
                        'assets/imagenes/usuario/icono_moneda.png',
                        height: 35,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '1100',
                        style: TextStyle(
                          color: simoAzul,
                          fontWeight: FontWeight.w600, // Outfit Semi-bold
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        'assets/imagenes/usuario/campana.png',
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                // Editar info button
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/editar_usuario',
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: simoAmarillo,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Editar\ninformación',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: simoAzul,
                                        fontWeight:
                                            FontWeight.w700, // Outfit bold
                                        fontSize: 13,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Avatar wrapper (border and image)
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: simoAmarillo,
                                          width: 4,
                                        ),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 45,
                                        backgroundColor: simoCrudo,
                                        backgroundImage: AssetImage(
                                          'assets/imagenes/usuario/usuario.png',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -15,
                                      child: Container(
                                        width: 80,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: simoAmarillo,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Text(
                                          'Juan\nSebastian',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: textoOscuro,
                                            fontWeight:
                                                FontWeight.w700, // Outfit bold
                                            fontSize: 12,
                                            height: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 18),

                                // Cerrar cuenta button
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFD4D4D4,
                                    ), // Light gray
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Cerrar cuenta',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textoOscuro,
                                      fontWeight:
                                          FontWeight.w700, // Outfit bold
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),

                          // Right Column: Info Card
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: simoCrudo,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      '¡Mi información!',
                                      style: TextStyle(
                                        color: simoMagenta,
                                        fontWeight: FontWeight
                                            .w800, // Outfit extra-bold
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildInfoItem(
                                    'Nombre',
                                    'Juan Sebastián Restrepo\nGómez (1 026 445 769)',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildInfoItem(
                                    'Teléfono',
                                    '+57 312 458 7692',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildInfoItem(
                                    'Dirección',
                                    'Calle 45 #72–18, Barrio\nLaureles Medellín, Antioquia',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildInfoItem(
                                    'Correo electrónico',
                                    'juan.restrepo@email.com',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFullWidthButton('Historial'),
                    const SizedBox(height: 10),
                    _buildFullWidthButton('Notificaciones'),
                    const SizedBox(height: 10),
                    Flexible(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: simoCrudo,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '¡Impacto con SIMÖ!',
                              style: TextStyle(
                                color: simoMagenta,
                                fontWeight: FontWeight.w800, // extra-bold
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Has reciclado 3 dispositivos\n',
                                              style: TextStyle(
                                                color: textoOscuro,
                                                fontSize: 12.5,
                                                fontWeight:
                                                    FontWeight.w500, // medium
                                                height: 1.4,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Evitaste 12 kg de residuos\nelectrónicos',
                                              style: TextStyle(
                                                color: textoOscuro,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight
                                                    .w800, // extra-bold
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Gracias por ayudar a reducir la\ncontaminación y construir una\nMedellín más sostenible.',
                                        style: TextStyle(
                                          color: textoOscuro,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500, // medium
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      top: 4.0,
                                    ),
                                    child: Image.asset(
                                      'assets/imagenes/usuario/reciclaje.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Center(
                              child: Text(
                                '¡Muchas gracias por ser parte del cambio!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800, // extra bold
                                  color: textoOscuro,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        decoration: const BoxDecoration(
          color: simoCrudo,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBottomNavItem(
              'Inicio',
              'assets/imagenes/usuario/icono_inicio.png',
              false,
              onTap: () => Navigator.pushReplacementNamed(context, '/opciones'),
            ),
            _buildBottomNavItem(
              'Opciones',
              'assets/imagenes/usuario/icono_opciones.png',
              false,
              onTap: () => Navigator.pushReplacementNamed(context, '/opciones'),
            ),
            _buildBottomNavItem(
              'Canjear',
              'assets/imagenes/usuario/icono_canjear.png',
              false,
              onTap: () => Navigator.pushReplacementNamed(context, '/canjear'),
            ),
            _buildBottomNavItem(
              'Usuario',
              'assets/imagenes/usuario/icono_usuario.png',
              true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: simoMagenta,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: simoMagenta,
                  fontWeight: FontWeight.w800, // extra-bold
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 2,
              ), // small visual gap between title and value
              Text(
                value,
                style: TextStyle(
                  color: textoOscuro,
                  fontWeight: FontWeight.w600, // semi-bold
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFullWidthButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: simoCrudo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textoOscuro,
          fontWeight: FontWeight.w700, // bold
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    String label,
    String iconPath,
    bool isSelected, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, height: 32),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: textoOscuro,
              fontWeight: FontWeight.w500, // outfit medium
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 40,
            color: isSelected ? simoMagenta : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
