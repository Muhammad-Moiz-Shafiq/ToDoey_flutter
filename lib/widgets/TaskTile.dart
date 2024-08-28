import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final void Function(bool?) callBackAddFunction;
  final void Function() callBackDelFunction;
  final void Function() callBackUpdateFunction;
  TaskTile(
      {required this.taskTitle,
      required this.isChecked,
      required this.callBackAddFunction,
      required this.callBackDelFunction,
      required this.callBackUpdateFunction});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () async {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final RenderBox listTile = context.findRenderObject() as RenderBox;
        final Offset listTilePosition =
            listTile.localToGlobal(Offset.zero, ancestor: overlay);
        final selectedOption = await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            listTilePosition.dx + listTile.size.width,
            listTilePosition.dy,
            listTilePosition.dx + listTile.size.width,
            listTilePosition.dy + listTile.size.height,
          ),
          items: [
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
            PopupMenuItem(
              value: 'update',
              child: Text('Update'),
            ),
          ],
        );
        if (selectedOption == 'delete') {
          callBackDelFunction();
        } else if (selectedOption == 'update') {
          callBackUpdateFunction();
        }
      },
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: callBackAddFunction,
      ),
    );
  }
}
