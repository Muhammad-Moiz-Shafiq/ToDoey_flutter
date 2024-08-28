class Tasks {
  int? id;
  String taskdes;
  bool isDone;

  Tasks({this.id, required this.taskdes, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskdes': taskdes,
      'isDone': isDone ? 1 : 0,
    };
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
