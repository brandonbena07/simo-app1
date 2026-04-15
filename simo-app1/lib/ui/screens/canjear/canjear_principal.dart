import 'package:flutter/material.dart';
import 'canjear_confirmacion.dart';

class CanjearPrincipal extends StatefulWidget {
  const CanjearPrincipal({super.key});

  @override
  State<CanjearPrincipal> createState() => _CanjearPrincipalState();
}

class _CanjearPrincipalState extends State<CanjearPrincipal> {
  static const Color simoMagenta = Color(0xFFD8006B);
  static const Color simoAmarillo = Color(0xFFF5B800);
  static const Color simoCrudo = Color(0xFFF7F4EC);
  static const Color textoOscuro = Color(0xFF333333);

  int _selectedNavIndex = 2;
  int _selectedRewardIndex = -1;

  final List<_RewardData> _rewards = const [
    _RewardData(
      logoName: 'falabella.png',
      title: '50% Descuento en Productos',
      subtitle: 'falabella',
      points: '1200',
    ),
    _RewardData(
      logoName: 'puntos_colombia.png',
      title: '200 Puntos Colombia',
      subtitle: 'Puntos Colombia',
      points: '900',
    ),
    _RewardData(
      logoName: 'bettys.png',
      title: '45% Descuento en comida',
      subtitle: 'Betty’s Bowls',
      points: '1200',
    ),
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/opciones');
        break;
      case 1:
        Navigator.pushNamed(context, '/opciones');
        break;
      case 2:
        // Already here
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/usuario');
        break;
    }
  }

  void _onRewardTap(int index) {
    setState(() {
      _selectedRewardIndex = index;
    });
    final reward = _rewards[index];
    _showMessage('Seleccionaste ${reward.title}');
  }

  void _onCanjearTap(int index) {
    final reward = _rewards[index];
    _showConfirmationDialog(reward);
  }

  void _showConfirmationDialog(_RewardData reward) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return CanjearConfirmacionDialog(
          onCancel: () {
            _showMessage('Canje cancelado.');
          },
        );
      },
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        Navigator.pushNamed(context, '/canjear/exito');
      }
    });
  }

  Widget _buildNavItem(String iconName, String label, int index) {
    final isSelected = _selectedNavIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onNavTap(index),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/imagenes/canjear/$iconName',
                width: 24,
                height: 24,
                color: isSelected ? simoMagenta : textoOscuro,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? simoMagenta : textoOscuro,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardCard(int index) {
    final reward = _rewards[index];
    final isSelected = _selectedRewardIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _onRewardTap(index),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border:
                isSelected ? Border.all(color: simoMagenta, width: 2) : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/imagenes/canjear/${reward.logoName}',
                        width: 110,
                        height: 26,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        reward.title,
                        style: const TextStyle(
                          color: textoOscuro,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        reward.subtitle,
                        style: const TextStyle(
                          color: Color(0xFF7B7B7B),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                onTap: () => _onCanjearTap(index),
                child: Container(
                  width: 96,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: simoAmarillo,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/imagenes/canjear/flor_negro.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        reward.points,
                        style: const TextStyle(
                          color: textoOscuro,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Canjear',
                        style: TextStyle(
                          color: textoOscuro,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: simoMagenta,
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            _buildNavItem('Inicio_icono.png', 'Inicio', 0),
            _buildNavItem('opciones_icono.png', 'Opciones', 1),
            _buildNavItem('Canjear_icono.png', 'Canjear', 2),
            _buildNavItem('usuario_icono.png', 'Usuario', 3),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: simoCrudo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        _showMessage('No hay pantalla anterior para volver.');
                      }
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/imagenes/canjear/atras.png',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Image.asset('assets/imagenes/canjear/simo.png', height: 32),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _showMessage('Ir a notificaciones'),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/imagenes/canjear/notificacion.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 9,
                          top: 8,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2D4EA2),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E6),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/imagenes/canjear/flor.png',
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '1300',
                            style: TextStyle(
                              color: textoOscuro,
                              fontWeight: FontWeight.w800,
                              fontSize: 42,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '¡Tu aporte al planeta está registrado!',
                            style: TextStyle(
                              color: textoOscuro,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Aprovecha tus puntos y gracias por ser parte del cambio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(_rewards.length, (index) {
                    final card = _buildRewardCard(index);
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == _rewards.length - 1 ? 0 : 14,
                      ),
                      child: card,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardData {
  final String logoName;
  final String title;
  final String subtitle;
  final String points;

  const _RewardData({
    required this.logoName,
    required this.title,
    required this.subtitle,
    required this.points,
  });
}
