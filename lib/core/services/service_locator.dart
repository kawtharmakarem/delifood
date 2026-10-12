import '/features/auth/cubit/auth_cubit.dart';
import '/features/home/cubit/home_cubit.dart';

import 'package:get_it/get_it.dart';

GetIt instance = GetIt.instance;
void setupDi() {
  instance.registerLazySingleton(() => AuthCubit());
  instance.registerFactory(() => HomeCubit());
}
