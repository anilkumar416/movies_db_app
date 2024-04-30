import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_db_app/movies/movies_bloc/movies_bloc.dart';
import 'package:movies_db_app/resources/app_router.dart';
import 'package:movies_db_app/resources/app_strings.dart';
import 'package:movies_db_app/resources/app_theme.dart';
import 'package:movies_db_app/services/service_locator.dart';

void main() {
  ServiceLocator.init();
  runApp(BlocProvider(
      create: (context) => sl<MoviesBloc>(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}
