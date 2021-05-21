import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:misg_meal_app/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoriteBloc favoriteBloc = Modular.get<FavoriteBloc>();
    return BlocProvider(
      create: (_) => favoriteBloc,
      child: MaterialApp(
        title: 'Meals',
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
          accentColor: Colors.green.shade600,
        ),
      ).modular(),
    );
  }
}
