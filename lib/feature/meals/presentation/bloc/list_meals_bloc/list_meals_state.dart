part of 'list_meals_bloc.dart';

abstract class ListMealsState extends Equatable {
  const ListMealsState();

  @override
  List<Object> get props => [];
}

class Empty extends ListMealsState {}

class Loading extends ListMealsState {}

class Loaded extends ListMealsState {
  final List<MealsEntity> meals;

  Loaded({@required this.meals});

  @override
  List<Object> get props => [meals];
}

class Error extends ListMealsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
