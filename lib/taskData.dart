import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'db/db_helper.dart';
import 'models/tasks.dart';

class TaskData extends ChangeNotifier {
  List<Tasks> _tasks = [];

  UnmodifiableListView<Tasks> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  TaskData() {
    loadData();
  }

  void loadData() async {
    _tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  void addTask(String newTask) async {
    Tasks task = Tasks(taskdes: newTask);
    await _dbHelper.insertTask(task);
    loadData();
  }

  void updateTask(Tasks task) async {
    task.toggleDone();
    await _dbHelper.updateTask(task);
    loadData();
  }

  void updateDesc(String updatedDesc, Tasks task) async {
    task.taskdes = updatedDesc;
    await _dbHelper.updateTask(task);
    loadData();
  }

  void deleteTask(Tasks task) async {
    await _dbHelper.deleteTask(task.id!);
    loadData();
  }
}
