import 'package:dartz/dartz.dart';
import '/app/failure.dart';
import '/data/data_sources/local_data_source.dart';
import '/data/data_sources/remote_data_source.dart';
import '/data/mapper/mapper.dart';
import '/data/network/network/network_info.dart';
import '/data/network/requests/auth_request.dart';
import '/domain/models/auth_models.dart';
import '/domain/models/home_models.dart';
import '/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetWorkInfo _netWorkInfo;
  RecipesModel? _recipesModel;

  RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._netWorkInfo,
  );
  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    if (await _netWorkInfo.hasConnection) {
      try {
        var response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: 1,
              message: response.message ?? ResponseMessage.unKnown,
            ),
          );
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(Failure.fromCode(ResponseCode.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> forgotpassword(String email) async {
    if (await _netWorkInfo.hasConnection) {
      try {
        var response = await _remoteDataSource.forgotpassword(email);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: 1,
              message: response.message ?? ResponseMessage.unKnown,
            ),
          );
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(Failure.fromCode(ResponseCode.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  ) async {
    if (await _netWorkInfo.hasConnection) {
      try {
        var response = await _remoteDataSource.register(registerRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: 1,
              message: response.message ?? ResponseMessage.unKnown,
            ),
          );
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e)); //dio error
      }
    } else {
      return Left(Failure.fromCode(ResponseCode.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, RecipesModel>> getHomeData() async {
    try {
      final myResponse = await _localDataSource.getHomeData();

      _recipesModel = myResponse.toDomain();
      return Right(myResponse.toDomain());
    } catch (e) {
      if (await _netWorkInfo.hasConnection) {
        try {
          var response = await _remoteDataSource.getHomeData();
          if (response.status == 0) {
            _localDataSource.saveHomeToCache(response);
            _recipesModel = response.toDomain();
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                code: 1,
                message: response.message ?? ResponseMessage.unKnown,
              ),
            );
          }
        } catch (e) {
          return Left(ErrorHandler.handle(e));
        }
      } else {
        return Left(Failure.fromCode(ResponseCode.noInternetConnection));
      }
    }
  }

  @override
  Future<Either<Failure, Recipe>> getRecipesById(int id) async {
    if (_recipesModel == null) {
      return Left(Failure.fromCode(ResponseCode.unKnown));
    }
    try {
      final recipe = _recipesModel!.recipes.firstWhere(
        (recipe) => recipe.id == id,
      );
      return Right(recipe);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
