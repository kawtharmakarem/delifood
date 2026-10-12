import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/data/network/requests/auth_request.dart';
import '/domain/models/auth_models.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/base_usecase.dart';

class LoginUseCase extends BaseUsecase<LoginUseCaseInput, Authentication> {
  final Repository repository;

  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, Authentication>> execute(
    LoginUseCaseInput input,
  ) async {
    return await repository.login(
      LoginRequest(email: input.email, password: input.password),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
