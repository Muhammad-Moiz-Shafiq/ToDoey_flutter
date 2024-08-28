import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../taskData.dart';
import 'TaskTile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final currentTask = taskData.tasks[index];
            return TaskTile(
              taskTitle: currentTask.taskdes,
              isChecked: currentTask.isDone,
              callBackAddFunction: (value) {
                taskData.updateTask(currentTask);
              },
              callBackDelFunction: () {
                taskData.deleteTask(currentTask);
              },
              callBackUpdateFunction: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String updatedDescription = currentTask.taskdes;
                    return AlertDialog(
                      title: Text('Update Task'),
                      content: TextField(
                        onChanged: (value) {
                          updatedDescription = value;
                        },
                        controller:
                            TextEditingController(text: currentTask.taskdes),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            taskData.updateDesc(
                                updatedDescription, currentTask);
                            Navigator.of(context).pop();
                          },
                          child: Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
