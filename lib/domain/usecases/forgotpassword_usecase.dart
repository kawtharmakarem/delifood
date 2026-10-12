import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/base_usecase.dart';

class ForgotpasswordUsecase extends BaseUsecase<String, String> {
  final Repository _repository;
  ForgotpasswordUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String email) async {
    return _repository.forgotpassword(email);
  }
}
