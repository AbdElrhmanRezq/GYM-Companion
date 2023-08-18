import 'package:flutter/material.dart';
import 'package:gym_app/data/workout_data.dart';
import 'package:gym_app/pages/exercise_book.dart';
import 'package:gym_app/pages/splash_screen.dart';
import 'package:gym_app/pages/workout_page.dart';
import 'package:gym_app/pages/home_page.dart';
import 'package:gym_app/themes/dark_theme.dart';
import 'package:gym_app/themes/light_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
//Init hive databasea
  await Hive.initFlutter();

//Open a hive box

  await Hive.openBox("workout_database");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return WorkoutData();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          initialRoute: 'splashScreen',
          routes: {
            'exerciseBook': (context) => const ExerciseBook(),
            'splashScreen': (context) => const SplashScreen(),
            'homePage': (context) => const HomePage(),
            'workoutPage': (context) => const WorkoutPage(),
          },
        ));
  }
}
