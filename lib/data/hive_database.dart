import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/workout.dart';
import 'package:hive_flutter/adapters.dart';

import '../date_time.dart/date_time.dart';

class HiveDatabase {
//Reference the hive box
  final _mybox = Hive.box("workout_database");

  bool prevDataExists() {
    if (_mybox.isEmpty) {
      print("No workout database");
      _mybox.put("START_DATE", todaysDate());
      return false;
    } else {
      print("previous Database detected");
      return true;
    }
  }

  //Get start date
  String getStartDate() {
    return _mybox.get("START_DATE");
  }

  //Write data in database
  void saveToDatabase(List<Workout> workouts) {
    final convertedWorkouts = convertWorkoutsToList(workouts);
    final convertedExercises = convertExercisesToList(workouts);

    if (exerciseCompleted(workouts)) {
      _mybox.put("COMPLETION_STATUS_${todaysDate()}", 1);
    } else {
      _mybox.put("COMPLETION_STATUS_${todaysDate()}", 0);
    }

    //Save workouts and exercises
    _mybox.put("WORKOUTS", convertedWorkouts);
    _mybox.put("EXERCISES", convertedExercises);
  }

  //Reading from hive database
  List<Workout> readFromDatabase() {
    List<Workout> savedWorkouts = [];

    //Get saved data
    List<String> workoutsList = _mybox.get("WORKOUTS");
    final exerciseList = _mybox.get("EXERCISES");

    //Convert saved data
    for (int i = 0; i < workoutsList.length; i++) {
      List<Exercise> exercisesInWorkout = [];
      for (int j = 0; j < exerciseList[i].length; j++) {
        exercisesInWorkout.add(Exercise(
            name: exerciseList[i][j][0],
            reps: exerciseList[i][j][1],
            sets: exerciseList[i][j][2],
            weight: exerciseList[i][j][3],
            isCompleted: exerciseList[i][j][4] == "true" ? true : false));
      }
      Workout singleWorkout =
          Workout(name: workoutsList[i], exercises: exercisesInWorkout);
      savedWorkouts.add(singleWorkout);
    }
    print(savedWorkouts);
    return savedWorkouts;
  }

  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompeletionStatus(String yyyymmdd) {
    return _mybox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
  }
}

//convert Workout to a list
List<String> convertWorkoutsToList(List<Workout> workouts) {
  List<String> workoutNames = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutNames.add(workouts[i].name);
  }
  return workoutNames;
}

//convert exercise to a list
List<List<List<String>>> convertExercisesToList(List<Workout> workouts) {
  List<List<List<String>>> exerciseNames = [
    // [
    //
    // [  [Curls , 12 ,2 2, 22],       [pullDown ,ddd ,22 ,22]  ]
    //
    // ]
  ];

  for (int i = 0; i < workouts.length; i++) {
    //Get Exercise List
    List<Exercise> exercisesInWorkout = workouts[i].exercises;

    //Make a List of workouts to add to exerciseNames
    List<List<String>> indiWorkout = [];

    //Loop through the exercisesList
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      //Get a certain exercise
      Exercise exercise = exercisesInWorkout[j];

      List<String> indiExercise = [];

      //Add exercise elements
      indiExercise.addAll([
        exercise.name,
        exercise.sets,
        exercise.reps,
        exercise.weight,
        exercise.isCompleted.toString()
      ]);

      //Add an exercise to a workout
      indiWorkout.add(indiExercise);
    }
    exerciseNames.add(indiWorkout);
  }
  return exerciseNames;
}
