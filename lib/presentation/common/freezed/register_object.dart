import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_object.freezed.dart';

@freezed
abstract class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String userName,
    String countryMobileCode,
    String mobileNumber,
    String email,
    String password,
    String profilePicture,
  ) = _RegisterObject;
}
