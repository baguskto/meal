import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/usecases/usecase.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/repositories/meals_repository.dart';

class DeleteFavorite implements UseCase<void, Params> {
  final MealsRepository repository;

  DeleteFavorite({
    @required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteFavoriteListMeals(params.entity);
  }
}

class Params extends Equatable {
  final MealsEntity entity;

  Params({@required this.entity});

  @override
  List<Object> get props => [entity];
}
