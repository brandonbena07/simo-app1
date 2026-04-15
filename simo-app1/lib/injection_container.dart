import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simo_app/data/datasources/auth_remote_datasource.dart';
import 'package:simo_app/data/repositories/auth_repository_impl.dart';
import 'package:simo_app/domain/repositories/auth_repository.dart';
import 'package:simo_app/domain/usecases/login_usecase.dart';
import 'package:simo_app/domain/usecases/register_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton(
    () => Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:3000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )),
  );
}
