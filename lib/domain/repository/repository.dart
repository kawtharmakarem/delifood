import 'package:dartz/dartz.dart';
import '/domain/models/auth_models.dart';
import '/domain/models/home_models.dart';

import '../../app/failure.dart';
import '../../data/network/requests/auth_request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotpassword(String email);
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  );
  Future<Either<Failure, RecipesModel>> getHomeData();
  Future<Either<Failure, Recipe>> getRecipesById(int id);
}
