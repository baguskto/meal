import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/usecases/usecase.dart';
import 'package:misg_meal_app/feature/meals/data/database/favorite_db.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/usecases/delete_favorite_meals.dart';
import 'package:misg_meal_app/feature/meals/domain/usecases/get_favorite_meals.dart';
import 'package:misg_meal_app/feature/meals/domain/usecases/save_favorite_meals.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AppDatabase database;
  final GetFavoriteMeals _favoriteMeals;
  final DeleteFavorite _deleteFavorite;
  final SaveFavoriteMeals _saveFavoriteMeals;
  FavoriteBloc({
    @required AppDatabase db,
    @required GetFavoriteMeals favoriteMeals,
    @required DeleteFavorite deleteFavorite,
    @required SaveFavoriteMeals saveFavoriteMeals,
  })  : database = db,
        _deleteFavorite = deleteFavorite,
        _favoriteMeals = favoriteMeals,
        _saveFavoriteMeals = saveFavoriteMeals,
        super(Empty());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is AddFavorite) {
      try {
        final data =
            await _saveFavoriteMeals(ParamsFavorite(entity: event.entity));
        yield data.fold(
          (l) => Error(message: 'database error'),
          (r) => AddSuccess(),
        );
      } catch (e) {
        print('object');
        yield Error(message: 'database error');
      }
    } else if (event is GetFavorite) {
      yield Loading();
      final data = await _favoriteMeals(NoParams());

      yield* _eitherLoadedOrErrorState(data);
      // print(data);
    } else if (event is DeleteFavoriteEvent) {
      try {
        var data = await _deleteFavorite(Params(entity: event.entity));
        yield data.fold(
          (l) => DeleteError(),
          (r) => DeleteSuccess(),
        );
      } catch (e) {
        yield DeleteError();
      }
    }
  }

  Stream<FavoriteState> _eitherLoadedOrErrorState(
    Either<Failure, List<MealsEntity>> failureOrMeals,
  ) async* {
    yield failureOrMeals.fold(
      (failure) => Error(message: 'There Is something wrong'),
      (meals) => Loaded(meals: meals),
    );
  }
}
