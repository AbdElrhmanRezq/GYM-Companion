import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_app/models/exercise_in_book.dart';
import 'package:http/http.dart' as http;

class MuscleExercises extends StatefulWidget {
  final String muscle;
  const MuscleExercises({super.key, required this.muscle});

  @override
  State<MuscleExercises> createState() => _MuscleExercisesState();
}

class _MuscleExercisesState extends State<MuscleExercises> {
  List<BookExercise> exercises = [];

  Future getExercise(String muscle) async {
    String apiKey = 'Your API key';
    String url = 'https://api.api-ninjas.com';
    String path = '/v1/exercises?muscle=';
    String fullURL = url + path + muscle;
    //print(fullURL);
    var response = await http.get(
      Uri.parse(fullURL),
      headers: {'X-Api-Key': apiKey},
    );
    var jsonData = jsonDecode(response.body);
    for (var eachExercise in jsonData) {
      BookExercise ex = BookExercise.fromJson(eachExercise);
      exercises.add(ex);
    }
  }

  void openTile(String exerciseName, String instructions) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(exerciseName),
        content: SingleChildScrollView(
          child: Text(instructions),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getExercise(widget.muscle);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.muscle),
      ),
      body: FutureBuilder(
        future: getExercise(widget.muscle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () {
                          openTile(exercises[index].name as String,
                              exercises[index].instructions as String);
                        },
                        title: Text(exercises[index].name as String),
                        subtitle: Wrap(
                          children: [
                            Chip(
                              label: Text(exercises[index].type as String),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(width: 2),
                            Chip(
                              label: Text(exercises[index].muscle as String),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(width: 2),
                            Chip(
                              label: Text(exercises[index].equipment as String),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(width: 2),
                            Chip(
                              label:
                                  Text(exercises[index].difficulty as String),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Text(
                              exercises[index].instructions as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }
}
