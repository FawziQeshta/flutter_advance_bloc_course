import 'package:dio/dio.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_service.dart';
import 'package:flutter_advance_bloc_course/core/networking/dio_factory.dart';
import 'package:flutter_advance_bloc_course/features/home/data/api/home_api_service.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_advance_bloc_course/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:flutter_advance_bloc_course/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repos/home_repo.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/login/data/repos/login_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  // SignUp
  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  // Home
  getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  // getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
/*
registerFactory
يعني كل ما بدي حاجة منها روح اعملي اوبجكت جديد

registerLazySingleton
اعملي نسخة واحدة من الاوبجكت وخلص
 */