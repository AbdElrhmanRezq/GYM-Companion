import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/components/drawer_nav.dart';
import 'package:gym_app/data/workout_data.dart';
import 'package:gym_app/models/workout.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  final newWorkoutNameController = TextEditingController();
  final editWorkoutNameController = TextEditingController();
  void goToWorkoutPage(String workoutName) {
    Navigator.pushNamed(context, 'workoutPage', arguments: workoutName);
  }

  void goToBook() {
    Navigator.pushNamed(context, 'exerciseBook');
  }

  void initEditors(String workoutName) {
    Workout workout = Provider.of<WorkoutData>(context, listen: false)
        .findWorkoutByName(workoutName);
    editWorkoutNameController.text = workout.name;
  }

  void addWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text("Add Workout"),
              content: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: newWorkoutNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    ok();
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

  void editWorkout(String workoutName) {
    initEditors(workoutName);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text("Edit Workout Name"),
              content: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: editWorkoutNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    edit(workoutName);
                  },
                  child: const Text("Edit"),
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

  //Warn the user when pressing the delete button
  void warnUser(String workoutName) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text("Are you sure you want to delete?"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    deleteWorkout(workoutName);
                  },
                  child: const Text("Yes"),
                ),
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text("No"),
                ),
              ],
            ));
  }

  //Delete Workout
  void deleteWorkout(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkout(workoutName);
    cancel();
  }

  //Edit method
  void edit(String workoutName) {
    String editWorkoutName = editWorkoutNameController.text;
    Workout workout = Provider.of<WorkoutData>(context, listen: false)
        .findWorkoutByName(workoutName);
    workout.name = editWorkoutName;
    Provider.of<WorkoutData>(context, listen: false).saveData();
    setState(() {});
    cancel();
  }

  //Ok method
  void ok() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    cancel();
    clearTextfield();
  }

  //Cancel method
  void cancel() {
    Navigator.of(context).pop();
  }

  //Clearing textfield method
  void clearTextfield() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const DrawerNav(),
        appBar: AppBar(
          title: Text("Workouts", style: GoogleFonts.lobster()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addWorkout();
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () {
                          goToWorkoutPage(value.getWorkoutList()[index].name);
                        },
                        title: Text(value.getWorkoutList()[index].name),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                warnUser(value.getWorkoutList()[index].name);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_note),
                              onPressed: () {
                                editWorkout(value.getWorkoutList()[index].name);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
