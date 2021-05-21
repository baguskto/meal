part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class Empty extends FavoriteState {}

class AddSuccess extends FavoriteState {}

class DeleteSuccess extends FavoriteState {}

class DeleteError extends FavoriteState {}

class Loading extends FavoriteState {}

class Loaded extends FavoriteState {
  final List<MealsEntity> meals;

  Loaded({@required this.meals});

  @override
  List<Object> get props => [meals];
}

class Error extends FavoriteState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
