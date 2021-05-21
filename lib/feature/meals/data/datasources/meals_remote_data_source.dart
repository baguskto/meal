import 'package:meta/meta.dart';
import 'package:misg_meal_app/core/error/exception.dart';
import 'package:misg_meal_app/core/network/dio_client.dart';
import 'package:misg_meal_app/feature/meals/data/models/list_meals_model.dart';

abstract class MealsRemoteDataSource {
  Future<ListMealModel> getListMeals(String search);
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final DioClient dio;

  MealsRemoteDataSourceImpl({@required this.dio});

  String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  @override
  Future<ListMealModel> getListMeals(String search) {
    return _getListMealFromUrl('search.php?s=$search');
  }

  Future<ListMealModel> _getListMealFromUrl(String url) async {
    try {
      final response = await dio.get(_baseUrl + url);
      print(response.data);
      final res = ListMealModel.fromJson(response.data);
      return res;
    } catch (e) {
      throw ServerException();
    }
  }
}
