import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _recordarDatos = false;
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _verPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Títulos
              const Text(
                '¡ HOLA !',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD8006B),
                ),
              ),
              const Text(
                'BIENVENIDO',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD8006B),
                ),
              ),
              const SizedBox(height: 24),
              // Fila inicia sesión + botón
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Inicia tu sesión',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD8006B),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD8006B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Tu eres..?'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Campo usuario
              const Text(
                'Nombre de usuario',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD8006B),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF0B8C8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Campo contraseña
              const Text(
                'Contraseña',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD8006B),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_verPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF0B8C8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _verPassword ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFFD8006B),
                    ),
                    onPressed: () {
                      setState(() {
                        _verPassword = !_verPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Checkbox y link
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _recordarDatos,
                        activeColor: const Color(0xFFD8006B),
                        onChanged: (value) {
                          setState(() {
                            _recordarDatos = value!;
                          });
                        },
                      ),
                      const Text(
                        'Recordar mis datos',
                        style: TextStyle(
                          color: Color(0xFFD8006B),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(
                      color: Color(0xFFD8006B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              // Botón iniciar sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD8006B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Texto ayuda
              const Center(
                child: Text(
                  'Tienes problemas al iniciar sesión? Te ayudamos.',
                  style: TextStyle(color: Color(0xFFD8006B), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
