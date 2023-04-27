import 'package:clean_architecture/data/network/app_api.dart';
import 'package:clean_architecture/data/network/requests.dart';
import 'package:clean_architecture/data/response/responses.dart';

abstract class RemoteDataSource{

  Future<AuthenticationResponse>login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse>forgetPassword(String email);

  Future<AuthenticationResponse>register(RegisterRequest registerRequest);

  Future<HomeResponse>getHomeData();

  Future<StoreDetailsResponse>getStoresDetails();

}

class RemoteDataSourceImpl implements RemoteDataSource{

  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{

    return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async{

    return await _appServiceClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async{

    return await _appServiceClient.register(registerRequest.userName,
        registerRequest.countryMobileCode, registerRequest.mobileNumber,
        registerRequest.email, registerRequest.password, "");
  }

  @override
  Future<HomeResponse> getHomeData()async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoresDetails() async{
    return await _appServiceClient.getStoreDetails();
  }
}