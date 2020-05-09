import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/Todo.dart';

import 'screens/screens.dart';

class Router {
  static toHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  static toAddTodo(BuildContext context, Function(String task, String note) onSave) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddEditTodoScreen(
                  isEdit: false,
                  onSave: onSave,
                )));
  }

  static toEditTodo(BuildContext context, Function(String task, String note) onSave, Todo todo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddEditTodoScreen(
              isEdit: true,
              onSave: onSave,
              todo: todo,
            )));
  }
}
