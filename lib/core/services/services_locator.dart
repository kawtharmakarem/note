import 'package:get_it/get_it.dart';

import '/core/cache/cache_helper.dart';
import '/core/database/sqflite_helper.dart';
import '/core/database/sqflite_repository.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/details/cubit/details_cubit.dart';
import '/features/home/cubit/home_cubit.dart';

final instance = GetIt.instance;
Future<void> getItSetup() async {
  instance.registerLazySingleton(() => SqfliteRepository());
  instance.registerLazySingleton(() => AuthCubit(instance()));
  instance.registerLazySingleton(() => CacheHelper());
  instance.registerLazySingleton(() => DBHelper());
  instance.registerLazySingleton(() => HomeCubit(instance(), instance()));
  instance.registerFactory(
    () => DetailsCubit(instance(), instance(), instance()),
  );
}
