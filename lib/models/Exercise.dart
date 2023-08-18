class Exercise {
  String name;
  String weight;
  String reps;
  String sets;
  bool isCompleted;
  Exercise(
      {required this.name,
      required this.reps,
      required this.sets,
      required this.weight,
      this.isCompleted = false});
}
