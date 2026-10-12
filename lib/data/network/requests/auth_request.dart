class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});
}

class RegisterRequest {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profilePicture;

  RegisterRequest({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
