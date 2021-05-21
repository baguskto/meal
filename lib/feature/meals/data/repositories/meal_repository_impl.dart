import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'package:misg_meal_app/core/error/exception.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/helper/network/network_info.dart';
import 'package:misg_meal_app/feature/meals/data/datasources/favorite_local_data_source.dart';
import 'package:misg_meal_app/feature/meals/data/datasources/meals_local_data_source.dart';
import 'package:misg_meal_app/feature/meals/data/datasources/meals_remote_data_source.dart';
import 'package:misg_meal_app/feature/meals/data/models/list_meals_model.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/repositories/meals_repository.dart';

typedef Future<ListMealModel> _ConcreteOrRandomChooser();

class MealRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final FavoriteLocalDataSource favoriteLocalDataSource;
  final MealsLocalDataSource mealsLocalDataSource;

  MealRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.favoriteLocalDataSource,
    @required this.mealsLocalDataSource,
  });
  @override
  Future<Either<Failure, List<MealsEntity>>> getListMeals(String search) async {
    return await _getMeals(() {
      return remoteDataSource.getListMeals(search);
    });
  }

  @override
  Future<Either<Failure, List<MealsEntity>>> getFavoriteListMeals() async {
    try {
      final data = await favoriteLocalDataSource.getListMeals();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavoriteListMeals(MealsEntity id) async {
    try {
      final response = await favoriteLocalDataSource.deleteMeals(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoriteListMeals(
      MealsEntity entity) async {
    try {
      final response = await favoriteLocalDataSource.saveMeals(entity);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<MealsEntity>>> _getMeals(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMeals = await getConcreteOrRandom();
        mealsLocalDataSource.cachedMeals(remoteMeals);
        return Right(remoteMeals.meals);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMeals = await mealsLocalDataSource.getLastMeals();
        return Right(localMeals.meals);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
