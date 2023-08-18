import 'package:flutter/material.dart';
import 'package:gym_app/data/hive_database.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final database = HiveDatabase();

  List<Workout> workouts = [
    Workout(name: "Leg", exercises: [
      Exercise(name: "Curls", reps: "10", sets: "3", weight: "60"),
    ]),
    Workout(name: "Push", exercises: [
      Exercise(name: "Bench Press", reps: "10", sets: "3", weight: "65"),
    ])
  ];

  //Initialize workoutList
  void initializeWorkoutList() {
    if (database.prevDataExists()) {
      workouts = database.readFromDatabase();
    } else {
      database.saveToDatabase(workouts);
    }
  }

  //Return List
  List<Workout> getWorkoutList() {
    return workouts;
  }

  //add Workout
  void addWorkout(String name) {
    workouts.add(Workout(name: name, exercises: []));
    notifyListeners();

    //Save to the database
    database.saveToDatabase(workouts);
  }

  //Delete Workout
  void deleteWorkout(String workoutName) {
    int found = workouts.indexWhere((element) => element.name == workoutName);
    workouts.removeAt(found);

    notifyListeners();

    //Save to the database
    database.saveToDatabase(workouts);
  }

  //Save data in the hive database
  void saveData() {
    database.saveToDatabase(workouts);
  }

  //Delete Workout
  void deleteExercise(String name, String workoutName) {
    Exercise exercise = findExerciseByName(name, workoutName);
    Workout workout = findWorkoutByName(workoutName);
    workout.exercises.remove(exercise);

    notifyListeners();

    //Save to the database
    database.saveToDatabase(workouts);
  }

  //add Exercise
  void addExercise(String name, String workoutName, String sets, String reps,
      String weight) {
    Workout workout = findWorkoutByName(workoutName);
    workout.exercises
        .add(Exercise(name: name, reps: reps, sets: sets, weight: weight));
    notifyListeners();

    //Save to the database
    database.saveToDatabase(workouts);
  }

  //checkoff
  void checkoff(String name, String workoutName) {
    Exercise exercise = findExerciseByName(name, workoutName);
    exercise.isCompleted = !exercise.isCompleted;
    notifyListeners();

    //Save to the database
    database.saveToDatabase(workouts);
  }
  //get Length of a workout

  //Find Workout
  Workout findWorkoutByName(String workoutName) {
    Workout found = workouts.firstWhere(
      (workout) => workout.name == workoutName,
    );
    return found;
  }

  //Find Exercise
  Exercise findExerciseByName(String exerciseName, String workoutName) {
    Workout workout = findWorkoutByName(workoutName);
    Exercise found = workout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return found;
  }

  //Get length of workout
  int getLengthOfWorkout(String name) {
    Workout found = findWorkoutByName(name);
    return found.exercises.length;
  }
}
