import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompeleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompeleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            //checkbox
            Checkbox(
              value: taskCompeleted,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            //text name
            Text(
              taskName,
              style: TextStyle(
                decoration: taskCompeleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
