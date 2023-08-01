import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';

import 'app/app.router.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[700],
      ),
      themeMode: ThemeMode.system,
      initialRoute: Routes.weatherView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
