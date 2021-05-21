import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:misg_meal_app/core/error/failures.dart';
import 'package:misg_meal_app/core/usecases/usecase.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/domain/repositories/meals_repository.dart';

class GetListMeals implements UseCase<List<MealsEntity>, Params> {
  final MealsRepository mealsRepository;

  GetListMeals(this.mealsRepository);

  @override
  Future<Either<Failure, List<MealsEntity>>> call(Params params) async {
    return await mealsRepository.getListMeals(params.search);
  }
}

class Params extends Equatable {
  final String search;

  Params({@required this.search});

  @override
  List<Object> get props => [search];
}
