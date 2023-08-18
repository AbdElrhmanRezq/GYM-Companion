import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.fitness_center_outlined,
                  size: 45,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("GYM Companion", style: GoogleFonts.lobster(fontSize: 20))
              ],
            ),
          ),
        ),
        nextScreen: HomePage(),
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Theme.of(context).colorScheme.background);
  }
}
