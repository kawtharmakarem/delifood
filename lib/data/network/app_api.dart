import 'package:dio/dio.dart';
import '/app/constants.dart';
import '/data/response/response.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST("/customers/forgotpassword")
  Future<ForgotpasswordResponse> forgotpassword(@Field("email") String email);
  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );
  @GET('/main')
  Future<HomeRecipesResponse> getHomeData();
}
