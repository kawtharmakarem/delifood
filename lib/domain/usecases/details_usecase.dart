import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/domain/models/home_models.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/base_usecase.dart';

class DetailsUsecase extends BaseUsecase<int, Recipe> {
  final Repository _repository;

  DetailsUsecase({required this._repository});
  @override
  Future<Either<Failure, Recipe>> execute(int input) async {
    return await _repository.getRecipesById(input);
  }
}
