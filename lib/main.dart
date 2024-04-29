import 'package:flutter/material.dart';
import 'package:movies_db_app/resources/app_router.dart';
import 'package:movies_db_app/resources/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}
