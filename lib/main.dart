import 'package:flutter/material.dart';
import 'ui/screens/notificaciones_screen.dart';

void main() {
  runApp(const SimoApp());
}

class SimoApp extends StatelessWidget {
  const SimoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMÖ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD8006B)),
        useMaterial3: true,
      ),
      home: const NotificacionesScreen(),
    );
  }
}


