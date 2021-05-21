import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:misg_meal_app/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart';
import 'package:misg_meal_app/feature/meals/presentation/pages/meals_homepage.dart';
import 'package:misg_meal_app/shared/colors.dart';

class ListMealsWidget extends StatelessWidget {
  final ListMealsBloc mealsBloc;

  const ListMealsWidget({
    Key key,
    @required this.mealsBloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: BlocBuilder<ListMealsBloc, ListMealsState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return state.meals.length == null
                ? Text('Data Not Found')
                : ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 170,
                          height: 60,
                          margin: EdgeInsets.only(right: 20),
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Modular.to.pushNamed(
                                  '/detailMeals',
                                  arguments: state.meals[index],
                                );
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.meals[index].strMealThumb,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${state.meals[index].strMeal}',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: titleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SubText(
                                          text:
                                              "${state.meals[index].strCategory}",
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'From ${state.meals[index].strArea}',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else if (state is Error) {
            return Text(state.message);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
