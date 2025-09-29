import 'package:dio/dio.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_service.dart';
import 'package:flutter_advance_bloc_course/core/networking/dio_factory.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repos/login_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));
}