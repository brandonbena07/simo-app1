import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../injection_container.dart';

// Estado
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UsuarioEntity usuario;
  AuthAuthenticated(this.usuario);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthRegistered extends AuthState {}

// Notifier
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthInitial();

  Future<void> login(String email, String password) async {
    state = AuthLoading();
    final result = await sl<LoginUseCase>().call(email, password);
    result.fold(
      (failure) => state = AuthError(failure.message),
      (usuario) => state = AuthAuthenticated(usuario),
    );
  }

  Future<void> register({
    required String nombre,
    required String cedula,
    required String telefono,
    required String direccion,
    required String email,
    required String password,
  }) async {
    state = AuthLoading();
    final result = await sl<RegisterUseCase>().call(
      nombre: nombre,
      cedula: cedula,
      telefono: telefono,
      direccion: direccion,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => state = AuthError(failure.message),
      (_) => state = AuthRegistered(),
    );
  }
}

// Provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
