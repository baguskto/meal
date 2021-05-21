part of 'list_meals_bloc.dart';

abstract class ListMealsEvent extends Equatable {
  const ListMealsEvent();

  @override
  List<Object> get props => [];
}

class GetListMeals extends ListMealsEvent {
  final String search;

  GetListMeals([this.search = '']);

  @override
  List<Object> get props => [search];
}
