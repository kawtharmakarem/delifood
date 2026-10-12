import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '/app/app_preferences.dart';
import '/data/data_sources/local_data_source.dart';
import '/data/data_sources/remote_data_source.dart';
import '/data/dio_factory.dart';
import '/data/network/app_api.dart';
import '/data/network/network/network_info.dart';
import '/data/repository/repository_impl.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/details_usecase.dart';
import '/domain/usecases/forgotpassword_usecase.dart';
import '/domain/usecases/home_usecase.dart';
import '/domain/usecases/login_use_case.dart';
import '/domain/usecases/register_usecase.dart';
import '/presentation/auth/auth_view_model/auth_view_model.dart';
import '/presentation/common/state_renderer/dialog_services.dart';
import '/presentation/forgotpassword/view_model/forgotpassword_viewmodel.dart';
import '/presentation/main/details/details_view_model.dart';
import '/presentation/main/main_view_model/main_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiServiceClient>(() => ApiServiceClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(appServiceClient: instance()),
  );
  instance.registerLazySingleton<NetWorkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance(), instance()),
  );
  instance.registerLazySingleton<DialogServices>(() => DialogServices());
  instance.registerLazySingleton<ImagePicker>(() => ImagePicker());
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}

//
Future<void> initAuthmodule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory(() => LoginUseCase(repository: instance()));
  }
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance.registerFactory<RegisterUsecase>(
      () => RegisterUsecase(instance()),
    );
  }
  if (!GetIt.I.isRegistered<AuthViewModel>()) {
    instance.registerFactory<AuthViewModel>(
      () => AuthViewModel(instance(), instance()),
    );
  }
}

//forgotpassword
Future<void> initForgotpassword() async {
  if (!GetIt.I.isRegistered<ForgotpasswordUsecase>()) {
    instance.registerFactory<ForgotpasswordUsecase>(
      () => ForgotpasswordUsecase(instance()),
    );
    instance.registerFactory<ForgotpasswordViewmodel>(
      () => ForgotpasswordViewmodel(instance()),
    );
  }
}

//main
Future<void> initMain() async {
  if (!GetIt.I.isRegistered<MainUsecase>()) {
    instance.registerFactory<MainUsecase>(() => MainUsecase(instance()));
    instance.registerFactory<MainViewModel>(() => MainViewModel(instance()));
  }
}

//details
Future<void> initDetails() async {
  if (!GetIt.I.isRegistered<DetailsUsecase>()) {
    instance.registerFactory<DetailsUsecase>(
      () => DetailsUsecase(repository: instance()),
    );
    instance.registerFactory<DetailsViewModel>(
      () => DetailsViewModel(detailsUsecase: instance()),
    );
  }
}
