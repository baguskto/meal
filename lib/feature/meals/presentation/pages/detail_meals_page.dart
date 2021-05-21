import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misg_meal_app/feature/meals/domain/entities/meal_entities.dart';
import 'package:misg_meal_app/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:misg_meal_app/shared/text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'meals_homepage.dart';

class DetailMealsPage extends StatelessWidget {
  final MealsEntity mealsEntity;

  const DetailMealsPage({
    Key key,
    @required this.mealsEntity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FavoriteBloc favoriteBloc = Modular.get<FavoriteBloc>();
    final subscription = favoriteBloc.stream;

    return BlocProvider.value(
      value: favoriteBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is AddSuccess) {
              print('sukses');
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Suksess')));
            } else if (state is Error) {
              print('error');
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Duplicate Favorite')));
            }
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsPreview(entity: mealsEntity),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                              mealsEntity.strMeal,
                              style: kSubTitleStyle,
                            ),
                            IconButton(
                              icon: Icon(Icons.bookmark_border),
                              onPressed: () {
                                favoriteBloc.add(AddFavorite(mealsEntity));
                                subscription.listen((event) {
                                  print(event);
                                });
                              },
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                mealsEntity.strCategory,
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SubText(
                                text: mealsEntity.strArea,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            mealsEntity.strInstructions,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Ingredient: ',
                            style: kSubTitleStyle,
                          ),
                          Text(
                              '- ${mealsEntity.strMeasure1} ${mealsEntity.strIngredient1}'),
                          Text(
                              '- ${mealsEntity.strMeasure2} ${mealsEntity.strIngredient2}'),
                          Text(
                              '- ${mealsEntity.strMeasure3} ${mealsEntity.strIngredient3}'),
                          Text(
                              '- ${mealsEntity.strMeasure4} ${mealsEntity.strIngredient4}'),
                          Text(
                              '- ${mealsEntity.strMeasure5} ${mealsEntity.strIngredient5}'),
                          Text(
                              '- ${mealsEntity.strMeasure6} ${mealsEntity.strIngredient6}'),
                          Text(
                              '- ${mealsEntity.strMeasure7} ${mealsEntity.strIngredient7}'),
                          Text(
                              '- ${mealsEntity.strMeasure8} ${mealsEntity.strIngredient8}'),
                          Text(
                              '- ${mealsEntity.strMeasure9} ${mealsEntity.strIngredient9}'),
                          Text(
                              '- ${mealsEntity.strMeasure10} ${mealsEntity.strIngredient10}'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    // TabBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsPreview extends StatelessWidget {
  const DetailsPreview({
    Key key,
    @required this.entity,
  }) : super(key: key);

  final MealsEntity entity;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: entity.idMeal,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              entity.strMealThumb,
              fit: BoxFit.fill,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1000,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AppIcons(
                      icon: Icons.arrow_back,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
