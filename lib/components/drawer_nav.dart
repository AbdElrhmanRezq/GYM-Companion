import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "GYM Companion",
                style: GoogleFonts.lobster(fontSize: 20),
              ),
            ),
          ),
          ListTile(
            title: const Text("Workouts"),
            leading: const Icon(Icons.fitness_center),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'homePage');
            },
          ),
          ListTile(
            title: const Text("Exercise Book"),
            leading: const Icon(Icons.book),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'exerciseBook');
            },
          )
        ],
      ),
    );
  }
}
