import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:habilita_enem/core/bloc/auth/auth_cubit.dart';
import 'package:habilita_enem/core/components/base_page/base_cubit.dart';
import 'package:habilita_enem/core/repository/auth/auth_repository.dart';
import 'package:habilita_enem/core/repository/auth/auth_repository_interface.dart';
import 'package:habilita_enem/core/repository/questions/questions_repository.dart';
import 'package:habilita_enem/core/repository/questions/questions_repository_interface.dart';
import 'package:habilita_enem/core/repository/user/user_repository.dart';
import 'package:habilita_enem/core/repository/user/user_repository_interface.dart';
import 'package:habilita_enem/core/service/http/http_service.dart';
import 'package:habilita_enem/core/service/http/http_service_interface.dart';
import 'package:habilita_enem/core/service/storage/storage_service.dart';
import 'package:habilita_enem/core/service/storage/storage_service_interface.dart';
import 'package:habilita_enem/pages/login/login_cubit.dart';
import 'package:habilita_enem/pages/quiz/quiz_cubit.dart';
import 'package:habilita_enem/pages/register/register_cubit.dart';
import 'package:habilita_enem/pages/reset_password/reset_password_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/reset_password_code/reset_password_code_cubit.dart';

class ServiceLocator {
  static Future<void> setup() async {
    final i = GetIt.instance;

    i.registerSingleton(await SharedPreferences.getInstance());

    // global cubits
    i.registerLazySingleton(() => FirebaseFirestore.instance);

    i.registerLazySingleton<IHttpService>(() => HttpService(i.get()));
    i.registerLazySingleton<IQuestionsRepository>(
        () => QuestionsRepository(i.get()));
    i.registerLazySingleton<IStorageService>(
        () => StorageService(i.get(), i.get()));

    i.registerLazySingleton(() => AuthCubit(i.get()));

    i.registerLazySingleton<IUserRepository>(() => UserRepository(i.get()));
    i.registerLazySingleton<IAuthRepository>(() => AuthRepository());
    // page cubits
    i.registerLazySingleton(() => BaseCubit(i.get()));
    i.registerLazySingleton(() => LoginCubit(i.get(), i.get()));
    i.registerLazySingleton(() => RegisterCubit(i.get(), i.get()));
    i.registerLazySingleton(() => ResetPasswordCubit());
    i.registerLazySingleton(() => ResetPasswordCodeCubit());
    i.registerLazySingleton(() => QuizCubit(i.get()));
  }
}
