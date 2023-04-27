import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/data/data_source/local_data_source.dart';
import 'package:clean_architecture/data/data_source/remote_data_source.dart';
import 'package:clean_architecture/data/network/app_api.dart';
import 'package:clean_architecture/data/network/dio_helper.dart';
import 'package:clean_architecture/data/network/network_info.dart';
import 'package:clean_architecture/data/repository_impl/repository_impl.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:clean_architecture/domain/usecase/forget_password_use_case.dart';
import 'package:clean_architecture/domain/usecase/home_use_case.dart';
import 'package:clean_architecture/domain/usecase/login_use_case.dart';
import 'package:clean_architecture/domain/usecase/register_use_case.dart';
import 'package:clean_architecture/domain/usecase/store_details_use_case.dart';
import 'package:clean_architecture/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:clean_architecture/presentation/home/pages/home/view_model/home_view_model.dart';
import 'package:clean_architecture/presentation/login/viewmodel/login_view_model.dart';
import 'package:clean_architecture/presentation/register/view_model/register_view_model.dart';
import 'package:clean_architecture/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule()async{
  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() =>AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(()
      => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioHelper>(()
  => DioHelper(instance()));

  Dio dio = await instance<DioHelper>().init();

  //app services client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));

  //local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //repository
  instance.registerLazySingleton<Repository>(()
  =>RepositoryImpl(instance(),instance(),instance()));



}

initLoginModule() {
   if(!GetIt.I.isRegistered<LoginUseCase>())
     {
       instance.registerFactory<LoginUseCase>(()=>LoginUseCase(instance()));
       instance.registerFactory<LoginViewModel>(()=>LoginViewModel(instance()));

     }
}

initForgetPasswordModule(){
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>())
    {
      instance.registerFactory<ForgetPasswordUseCase>(()=>ForgetPasswordUseCase(instance()));
      instance.registerFactory<ForgetPasswordViewModel>(()=>ForgetPasswordViewModel(instance()));
    }
}

initRegisterModule() {
  if(!GetIt.I.isRegistered<RegisterUseCase>())
  {
    instance.registerFactory<RegisterUseCase>(()=>RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(()=>RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(()=>ImagePicker());

  }
}
initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule()
{
  if(!GetIt.I.isRegistered<StoreDetailsUseCase>())
  {
    instance.registerFactory<StoreDetailsUseCase>(()=>StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(()=>StoreDetailsViewModel(instance()));

  }
}
