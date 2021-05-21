import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misg_meal_app/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteBloc favoriteBloc;

  @override
  void initState() {
    favoriteBloc = Modular.get<FavoriteBloc>();
    favoriteBloc.add(GetFavorite());
    super.initState();
  }

  @override
  void dispose() {
    favoriteBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteBloc,
      // value: favoriteBloc,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber,
          title: Text('List Favorite'),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            print(state);
            if (state is Loaded) {
              if (state.meals.isEmpty) {
                return Text('anda belum memilih favorite');
              } else {
                return ListView.builder(
                  itemCount: state.meals.length,
                  itemBuilder: (context, i) {
                    return BlocListener<FavoriteBloc, FavoriteState>(
                      listener: (context, state) {
                        print(state);
                        if (state is DeleteSuccess) {
                          favoriteBloc.add(GetFavorite());
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Delete Success')));
                        } else if (state is DeleteError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Delete Gagal')));
                        }
                      },
                      child: ListTile(
                        onTap: () => Modular.to.pushNamed(
                          '/detailMeals',
                          arguments: state.meals[i],
                        ),
                        title: Text(state.meals[i].strMeal),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            favoriteBloc
                                .add(DeleteFavoriteEvent(state.meals[i]));
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (state is Error) {
              return Text('error');
            } else if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
