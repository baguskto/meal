import 'package:dartz/dartz.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';

abstract class MealsRepository {
  Future<Either<Failure, List<MealsEntity>>> getListMeals(String search);

  Future<Either<Failure, List<MealsEntity>>> getFavoriteListMeals();

  Future<Either<Failure, void>> deleteFavoriteListMeals(MealsEntity id);

  Future<Either<Failure, void>> saveFavoriteListMeals(MealsEntity entity);
}
