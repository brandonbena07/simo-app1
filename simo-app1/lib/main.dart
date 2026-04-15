import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'injection_container.dart' as di;
import 'ui/screens/Opciones/opciones_screen.dart';
import 'ui/screens/Opciones/busqueda_screen.dart';
import 'ui/screens/canjear/canjear_principal.dart';
import 'ui/screens/canjear/canjear_exito.dart';
import 'ui/screens/usuario/usuario_menu.dart';
import 'ui/screens/usuario/editar_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: SimoApp()));
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
      routes: {
        '/opciones': (context) => OpcionesScreen(),
        '/busqueda': (context) => BusquedaScreen(),
        '/canjear': (context) => CanjearPrincipal(),
        '/canjear/exito': (context) => CanjearExitoScreen(),
        '/usuario': (context) => UsuarioMenuScreen(),
        '/editar_usuario': (context) => EditarUsuarioScreen(),
      },
      home: OpcionesScreen(),
    );
  }
}
