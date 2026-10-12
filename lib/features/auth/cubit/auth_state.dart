sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthChangeSelectedTab extends AuthState {}

final class AuthLoginObsecure extends AuthState {}

final class AuthGenerateItems extends AuthState {}

final class AuthRegisterObsecure extends AuthState {}
