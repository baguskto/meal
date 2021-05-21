import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/usecases/usecase.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/repositories/meals_repository.dart';

class GetFavoriteMeals implements UseCase<List<MealsEntity>, NoParams> {
  final MealsRepository repository;

  GetFavoriteMeals({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<MealsEntity>>> call(NoParams params) async {
    return await repository.getFavoriteListMeals();
  }
}
