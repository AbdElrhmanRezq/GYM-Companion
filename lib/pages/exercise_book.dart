import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/components/drawer_nav.dart';
import 'package:gym_app/components/muscle_tile.dart';

class ExerciseBook extends StatefulWidget {
  const ExerciseBook({super.key});

  @override
  State<ExerciseBook> createState() => _ExerciseBookState();
}

class _ExerciseBookState extends State<ExerciseBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const DrawerNav(),
      appBar: AppBar(
        title: Text(
          "Exercises Book",
          style: GoogleFonts.lobster(),
        ),
      ),
      body: ListView(
        children: [
          MuscleTile(name: 'Chest'),
          MuscleTile(name: 'Lower_Back'),
          MuscleTile(name: 'Middle_Back'),
          MuscleTile(name: 'lats'),
          MuscleTile(name: 'Forearms'),
          MuscleTile(name: 'Traps'),
          MuscleTile(name: 'Biceps'),
          MuscleTile(name: 'Triceps'),
          MuscleTile(name: 'Quadriceps'),
          MuscleTile(name: 'Hamstrings'),
          MuscleTile(name: 'Glutes'),
          MuscleTile(name: "Calves")
        ],
      ),
    );
  }
}
