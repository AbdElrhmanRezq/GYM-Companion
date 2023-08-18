import 'package:flutter/material.dart';
import 'package:gym_app/components/exercise_tile.dart';
import 'package:gym_app/data/workout_data.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //Adding exercise controllers
  final newExerciseNameController = TextEditingController();
  final newExerciseSetsController = TextEditingController();
  final newExerciseRepsController = TextEditingController();
  final newExercisetWeightController = TextEditingController();

  //Editing exercise controllers
  final exerciseNameEditer = TextEditingController();
  final exerciseSetsEditer = TextEditingController();
  final exerciseRepsEditer = TextEditingController();
  final exerciseWeightEditer = TextEditingController();

  //Initializing exercise controllers
  void initEditors(String exerciseName, String workoutName) {
    Exercise exercise = Provider.of<WorkoutData>(context, listen: false)
        .findExerciseByName(exerciseName, workoutName);
    exerciseNameEditer.text = exercise.name;
    exerciseSetsEditer.text = exercise.sets;
    exerciseRepsEditer.text = exercise.reps;
    exerciseWeightEditer.text = exercise.weight;
  }

  void addExercise(String workoutName) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Exercise"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: "Name"),
                    controller: newExerciseNameController,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Sets"),
                    controller: newExerciseSetsController,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Reps"),
                    controller: newExerciseRepsController,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Weight"),
                    controller: newExercisetWeightController,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    ok(workoutName);
                  },
                  child: const Text("Ok"),
                ),
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  //View and edit exercise
  void editExercise(String exerciseName, String workoutName) {
    initEditors(exerciseName, workoutName);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Edit Exercise"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: "Name"),
                    controller: exerciseNameEditer,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Sets"),
                    controller: exerciseSetsEditer,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Reps"),
                    controller: exerciseRepsEditer,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Weight"),
                    controller: exerciseWeightEditer,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    edit(exerciseName, workoutName);
                  },
                  child: const Text("Ok"),
                ),
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  //Editing method
  void edit(String exerciseName, String workoutName) {
    String newExerciseName = exerciseNameEditer.text;
    String newExerciseSets = exerciseSetsEditer.text;
    String newExerciseReps = exerciseRepsEditer.text;
    String newExerciseWeight = exerciseWeightEditer.text;
    Exercise exercise = Provider.of<WorkoutData>(context, listen: false)
        .findExerciseByName(exerciseName, workoutName);
    exercise.name = newExerciseName;
    exercise.sets = newExerciseSets;
    exercise.reps = newExerciseReps;
    exercise.weight = newExerciseWeight;
    cancel();
    Provider.of<WorkoutData>(context, listen: false).saveData();
    setState(() {});
  }

  //Ok method
  void ok(String workoutName) {
    String newExerciseName = newExerciseNameController.text;
    String newExerciseSets = newExerciseSetsController.text;
    String newExerciseReps = newExerciseRepsController.text;
    String newExerciseWeight = newExercisetWeightController.text;

    Provider.of<WorkoutData>(context, listen: false).addExercise(
        newExerciseName,
        workoutName,
        newExerciseSets,
        newExerciseReps,
        newExerciseWeight);
    cancel();
    clearTextfield();
  }

  //Deleting an workout

  //Cancel method
  void cancel() {
    Navigator.of(context).pop();
  }

  //Clearing textfield method
  void clearTextfield() {
    newExerciseNameController.clear();
    newExerciseSetsController.clear();
    newExerciseRepsController.clear();
    newExercisetWeightController.clear();
  }

  void onCheckboxChange(String exerciseName, String workoutName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkoff(exerciseName, workoutName);
  }

  void updateTiles(int oldIndex, int newIndex, String workoutName) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    Exercise exercise = Provider.of<WorkoutData>(context)
        .findWorkoutByName(workoutName)
        .exercises
        .removeAt(oldIndex);
    Provider.of<WorkoutData>(context)
        .findWorkoutByName(workoutName)
        .exercises
        .insert(newIndex, exercise);
  }

  @override
  Widget build(BuildContext context) {
    final workoutName = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text(workoutName),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addExercise(workoutName);
            },
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: value.getLengthOfWorkout(workoutName),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.primary),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ExerciseTile(
                    exerciseName: value
                        .findWorkoutByName(workoutName)
                        .exercises[index]
                        .name,
                    sets: value
                        .findWorkoutByName(workoutName)
                        .exercises[index]
                        .sets,
                    reps: value
                        .findWorkoutByName(workoutName)
                        .exercises[index]
                        .reps,
                    weight: value
                        .findWorkoutByName(workoutName)
                        .exercises[index]
                        .weight,
                    isCompleted: value
                        .findWorkoutByName(workoutName)
                        .exercises[index]
                        .isCompleted,
                    onChanged: (val) {
                      onCheckboxChange(
                        value
                            .findWorkoutByName(workoutName)
                            .exercises[index]
                            .name,
                        workoutName,
                      );
                    },
                    workoutName: workoutName,
                    editExercise: () {
                      editExercise(
                          value
                              .findWorkoutByName(workoutName)
                              .exercises[index]
                              .name,
                          workoutName);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
