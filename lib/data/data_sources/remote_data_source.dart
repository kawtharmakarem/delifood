import '/data/network/app_api.dart';
import '/data/network/requests/auth_request.dart';
import '/data/response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotpasswordResponse> forgotpassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeRecipesResponse> getHomeData();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiServiceClient _appServiceClient;

  RemoteDataSourceImpl({required this._appServiceClient});

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgotpasswordResponse> forgotpassword(String email) async {
    return await _appServiceClient.forgotpassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
    RegisterRequest registerRequest,
  ) async {
    return await _appServiceClient.register(
      registerRequest.userName,
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.email,
      registerRequest.password,
      "",
    );
  }

  @override
  Future<HomeRecipesResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }
}
