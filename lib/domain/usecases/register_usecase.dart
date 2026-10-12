// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/data/network/requests/auth_request.dart';
import '/domain/models/auth_models.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/base_usecase.dart';

class RegisterUsecase
    extends BaseUsecase<RegisterUsecaseInputs, Authentication> {
  final Repository _repository;
  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
    RegisterUsecaseInputs input,
  ) async {
    return await _repository.register(
      RegisterRequest(
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobileNumber: input.mobileNumber,
        email: input.email,
        password: input.password,
        profilePicture: input.profilePicture,
      ),
    );
  }
}

class RegisterUsecaseInputs {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profilePicture;
  RegisterUsecaseInputs({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
