import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/domain/models/home_models.dart';
import '/domain/repository/repository.dart';
import '/domain/usecases/base_usecase.dart';

class MainUsecase extends BaseUsecase<void, RecipesModel> {
  final Repository _repository;
  MainUsecase(this._repository);
  @override
  Future<Either<Failure, RecipesModel>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
