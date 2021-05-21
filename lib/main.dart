import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:misg_meal_app/core/bloc_observer.dart';

import 'app.dart';
import 'app_module.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    ModularApp(
      module: AppModule(),
      child: App(),
    ),
  );
}
