import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:misg_meal_app/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart';
import 'package:misg_meal_app/feature/meals/presentation/widgets/list_meal_widget.dart';
import 'package:misg_meal_app/shared/colors.dart';
import 'package:misg_meal_app/shared/text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsHomePage extends StatefulWidget {
  @override
  _MealsHomePageState createState() => _MealsHomePageState();
}

class _MealsHomePageState extends State<MealsHomePage> {
  ListMealsBloc mealsBloc;
  // FavoriteBloc favoriteBloc;

  @override
  void initState() {
    mealsBloc = Modular.get<ListMealsBloc>();
    // favoriteBloc = Modular.get<FavoriteBloc>();
    mealsBloc.add(GetListMeals());
    super.initState();
  }

  @override
  void dispose() {
    mealsBloc?.close();
    // favoriteBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mealsBloc,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.amber,
              elevation: 0,
              pinned: true,
              centerTitle: true,
              title: SearchBox(
                mealsBloc: mealsBloc,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black45,
                  ),
                  onPressed: () => Modular.to.pushNamed('/favoriteMeals'),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Make your own meal",
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Best recipe",
                      style: kSubTitleStyle,
                    ),
                    Container(
                      child: ListMealsWidget(
                        mealsBloc: mealsBloc,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final ListMealsBloc mealsBloc;

  const SearchBox({Key key, @required this.mealsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextFormField(
        onChanged: (val) {
          print(val);
          mealsBloc.add(GetListMeals(val));
        },
        decoration: InputDecoration(
          hintText: "Search Meals...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color color;
  AppIcons({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.3),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String text;
  SubText({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w700,
          color: titleColor.withOpacity(0.5),
          fontSize: 18,
        ));
  }
}
