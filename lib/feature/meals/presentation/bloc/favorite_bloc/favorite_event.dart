part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteEvent {
  final MealsEntity entity;

  AddFavorite(this.entity);

  @override
  List<Object> get props => [entity];
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final MealsEntity entity;

  DeleteFavoriteEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

class GetFavorite extends FavoriteEvent {}
