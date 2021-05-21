import 'package:moor_flutter/moor_flutter.dart';
part 'favorite_db.g.dart';

@DataClassName('FavoriteTable') //Final Table Name
class FavoritesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get strMeal => text()();
  TextColumn get strCategory => text()();
  TextColumn get strArea => text()();
  TextColumn get strInstructions => text()();
  TextColumn get strMealThumb => text()();
  TextColumn get strTags => text()();
  TextColumn get strYoutube => text()();
  TextColumn get strIngredient1 => text()();
  TextColumn get strIngredient2 => text()();
  TextColumn get strIngredient3 => text()();
  TextColumn get strIngredient4 => text()();
  TextColumn get strIngredient5 => text()();
  TextColumn get strIngredient6 => text()();
  TextColumn get strIngredient7 => text()();
  TextColumn get strIngredient8 => text()();
  TextColumn get strIngredient9 => text()();
  TextColumn get strIngredient10 => text()();
  TextColumn get strIngredient11 => text()();
  TextColumn get strIngredient12 => text()();
  TextColumn get strIngredient13 => text()();
  TextColumn get strIngredient14 => text()();
  TextColumn get strIngredient15 => text()();
  TextColumn get strIngredient16 => text()();
  TextColumn get strIngredient17 => text()();
  TextColumn get strIngredient18 => text()();
  TextColumn get strIngredient19 => text()();
  TextColumn get strIngredient20 => text()();
  TextColumn get strMeasure1 => text()();
  TextColumn get strMeasure2 => text()();
  TextColumn get strMeasure3 => text()();
  TextColumn get strMeasure4 => text()();
  TextColumn get strMeasure5 => text()();
  TextColumn get strMeasure6 => text()();
  TextColumn get strMeasure7 => text()();
  TextColumn get strMeasure8 => text()();
  TextColumn get strMeasure9 => text()();
  TextColumn get strMeasure10 => text()();
  TextColumn get strMeasure11 => text()();
  TextColumn get strMeasure12 => text()();
  TextColumn get strMeasure13 => text()();
  TextColumn get strMeasure14 => text()();
  TextColumn get strMeasure15 => text()();
  TextColumn get strMeasure16 => text()();
  TextColumn get strMeasure17 => text()();
  TextColumn get strMeasure18 => text()();
  TextColumn get strMeasure19 => text()();
  TextColumn get strMeasure20 => text()();
  TextColumn get strSource => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [FavoritesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;

  Future<List<FavoriteTable>> checkIsFavorite(int id) =>
      (select(favoritesTable)..where((tbl) => tbl.id.equals(id))).get();
  Future<List<FavoriteTable>> getAllOrder() => select(favoritesTable).get();
  Stream<List<FavoriteTable>> watchAllOrder() => select(favoritesTable).watch();
  Future insertNewOrder(FavoriteTable order) =>
      into(favoritesTable).insert(order);
  Future deleteOrder(FavoriteTable order) =>
      delete(favoritesTable).delete(order);
}
