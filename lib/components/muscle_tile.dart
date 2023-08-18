import 'package:flutter/material.dart';
import 'package:gym_app/pages/muscle_exercises.dart';

class MuscleTile extends StatelessWidget {
  final String name;
  MuscleTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
        child: Container(
          height: 80,
          width: double.minPositive,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MuscleExercises(muscle: name.toLowerCase())),
                );
              },
            ),
          ),
        ));
  }
}
