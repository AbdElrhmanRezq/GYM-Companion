import 'package:flutter/material.dart';
import 'package:gym_app/data/workout_data.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String sets;
  final String reps;
  final String weight;
  final bool isCompleted;
  void Function(bool?)? onChanged;
  final String workoutName;
  final Function editExercise;

  ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.sets,
      required this.reps,
      required this.weight,
      required this.isCompleted,
      required this.onChanged,
      required this.workoutName,
      required this.editExercise});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        editExercise();
      },
      title: Text(exerciseName),
      subtitle: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Chip(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                label: Text("$sets set", style: const TextStyle(fontSize: 12))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Chip(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                label: Text("$reps rep", style: const TextStyle(fontSize: 12))),
          ),
          Chip(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              label: Text("$weight Kg", style: const TextStyle(fontSize: 12))),
        ],
      ),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: (value) => onChanged!(value),
            ),
            IconButton(
                onPressed: () {
                  Provider.of<WorkoutData>(context, listen: false)
                      .deleteExercise(exerciseName, workoutName);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
