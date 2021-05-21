import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/usecases/usecase.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/repositories/meals_repository.dart';

class SaveFavoriteMeals implements UseCase<void, ParamsFavorite> {
  final MealsRepository repository;

  SaveFavoriteMeals({
    @required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(ParamsFavorite params) async {
    return await repository.saveFavoriteListMeals(params.entity);
  }
}

class ParamsFavorite extends Equatable {
  final MealsEntity entity;

  ParamsFavorite({@required this.entity});

  @override
  List<Object> get props => [entity];
}
