import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgetsopciones/simo_header.dart';
import '../../widgets/widgetsopciones/simo_bottom_nav.dart';
import 'detalle_solicitud_screen.dart';
import 'opciones_screen.dart';

class BusquedaScreen extends StatefulWidget {
  const BusquedaScreen({super.key});

  @override
  State<BusquedaScreen> createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  String? selectedDispositivo;
  dynamic selectedIcon;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredDispositivos = [];

  final List<Map<String, dynamic>> dispositivos = [
    {'name': 'Tableta', 'icon': 'assets/imagenes/opciones/tablet_icono.png'},
    {'name': 'Cargadores', 'icon': 'assets/imagenes/opciones/cargadores.png'},
    {
      'name': 'Consolas de Juegos',
      'icon': 'assets/imagenes/opciones/consolasdejuegos.png',
    },
    {'name': 'Mouse o Teclado', 'icon': 'assets/imagenes/opciones/mouse.png'},
    {'name': 'Microondas', 'icon': 'assets/imagenes/opciones/microondas.png'},
    {'name': 'Ventilador', 'icon': 'assets/imagenes/opciones/ventilador.png'},
    {'name': 'Laptop', 'icon': 'assets/imagenes/opciones/laptop.png'},
    {'name': 'Plancha', 'icon': 'assets/imagenes/opciones/plancha.png'},
    {'name': 'Licuadora', 'icon': 'assets/imagenes/opciones/licuadora.png'},
    {'name': 'Celular', 'icon': 'assets/imagenes/opciones/celular.png'},
    {'name': 'Batería', 'icon': 'assets/imagenes/opciones/bateria.png'},
    {'name': 'TV o Monitor', 'icon': 'assets/imagenes/opciones/tv.png'},
    {
      'name': 'Refrigerador',
      'icon': 'assets/imagenes/opciones/refrigerador.png',
    },
    {'name': 'Cables', 'icon': 'assets/imagenes/opciones/cables.png'},
    {'name': 'Otros', 'icon': 'assets/imagenes/opciones/otrosdispositivos.png'},
  ];

  @override
  void initState() {
    super.initState();
    filteredDispositivos = List.from(dispositivos);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final text = _searchController.text.toLowerCase().trim();
    setState(() {
      if (text.isEmpty) {
        filteredDispositivos = List.from(dispositivos);
      } else {
        final matches = dispositivos.where((d) {
          return d['name'].toString().toLowerCase().contains(text);
        }).toList();

        matches.sort((a, b) {
          final aName = a['name'].toString().toLowerCase();
          final bName = b['name'].toString().toLowerCase();
          final aStarts = aName.startsWith(text);
          final bStarts = bName.startsWith(text);

          if (aStarts && !bStarts) return -1;
          if (!aStarts && bStarts) return 1;
          return aName.compareTo(bName);
        });

        filteredDispositivos = matches;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.simoAzul,
      appBar: SimoHeader(
        showBackButton: true,
        showLogo: false,
        puntos: 1780,
        onBackPressed: () => _showConfirmarCancelacion(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.simoCrudo,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF424242),
                        size: 20,
                      ),
                      border: InputBorder.none,
                      hintText: 'Busca tu dispositivo...',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.simoAzul,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                selectedDispositivo == null
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.simoCrudo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          itemCount: filteredDispositivos.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.withOpacity(0.2),
                            indent: 10,
                            endIndent: 10,
                          ),
                          itemBuilder: (context, index) {
                            final d = filteredDispositivos[index];
                            return _buildItem(d['name'], d['icon']);
                          },
                        ),
                      )
                    : Column(
                        children: [
                          const Text(
                            'Elige el destino de tu dispositivo:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          _buildDestinoCard(
                            aliado: 'EcoTech',
                            direccion: 'Calle 50 #45-23, Medellín',
                            metodo: 'Lo llevas tú',
                            puntos: 1780,
                            colorBoton: const Color(0xFFD3CFCF),
                          ),
                          const SizedBox(height: 8),
                          _buildDestinoCard(
                            aliado: 'Monterray',
                            direccion: 'Carrera 48 # 10-45',
                            metodo: 'Lo recogemos',
                            puntos: 1150,
                            colorBoton: AppColors.simoAmarillo,
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedDispositivo = null;
                                selectedIcon = null;
                              });
                            },
                            child: const Text(
                              'Cambiar dispositivo',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SimoBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const OpcionesScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            // Canjear no tiene funcionalidad por el momento
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _showConfirmarCancelacion(BuildContext context) {
    if (selectedDispositivo == null) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.simoCrudo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '¿Deseas cancelar la solicitud?',
          style: TextStyle(
            color: AppColors.simoMagenta,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Si sales ahora, se perderán los datos de selección actuales.',
          style: TextStyle(color: Color(0xFF424242)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Color(0xFF6E6E6E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                color: AppColors.simoMagenta,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String name, dynamic icon) {
    bool isSelected = selectedDispositivo == name;
    return InkWell(
      onTap: () {
        setState(() {
          selectedDispositivo = name;
          selectedIcon = icon;
        });
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.simoAmarillo.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            icon is String
                ? Image.asset(icon, height: 15, width: 15, fit: BoxFit.contain)
                : Icon(icon, color: const Color(0xFF424242), size: 15),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF424242),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: AppColors.simoAmarillo,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDestinoCard({
    required String aliado,
    required String direccion,
    required String metodo,
    required int puntos,
    required Color colorBoton,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetalleSolicitudScreen(
              dispositivoLabel: selectedDispositivo!,
              dispositivoIcon: selectedIcon!,
              destinoAliado: aliado,
              destinoDireccion: direccion,
              metodoEntrega: metodo,
            ),
          ),
        );
      },
      child: Container(
        height: 72,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: AppColors.simoCrudo,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.simoAmarillo,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 6,
                    right: 8,
                    child: Text(
                      '1x',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        color: Color(0xFF424242),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (selectedIcon != null)
                          selectedIcon is String
                              ? Image.asset(
                                  selectedIcon!,
                                  height: 28,
                                  width: 28,
                                  fit: BoxFit.contain,
                                )
                              : Icon(
                                  selectedIcon,
                                  size: 28,
                                  color: const Color(0xFF333333),
                                ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            selectedDispositivo ?? '',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF424242),
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Destino: $aliado',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            direccion,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xFF6E6E6E),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: metodo == 'Lo recogemos'
                                  ? AppColors.simoAmarillo
                                  : const Color(0xFFD3CFCF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              metodo,
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/imagenes/canjear/flor.png',
                              height: 22,
                              width: 22,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '$puntos',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
