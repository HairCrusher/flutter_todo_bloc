import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/Todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function onDismissed;
  final Function onChanged;
  final Function onTap;

  TodoItem({
    @required key,
    @required this.todo,
    @required this.onDismissed,
    @required this.onChanged,
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      dismissThresholds: {
        DismissDirection.startToEnd: 0.2,
        DismissDirection.endToStart: 0.2
      },
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: this.todo.complete,
          onChanged: onChanged,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(todo.task),
        ),
        subtitle: todo.note.isNotEmpty ? Text(todo.note) : null,
      ),
    );
  }
}
