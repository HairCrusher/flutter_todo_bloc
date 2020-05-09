import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/Todo.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Function(String task, String note) onSave;
  final bool isEdit;
  final Todo todo;

  AddEditTodoScreen({@required this.onSave, @required this.isEdit, this.todo});

  @override
  State<StatefulWidget> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isEdit => widget.isEdit;

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактирование заметки' : 'Создание заметки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: isEdit ? widget.todo.task : '',
                autofocus: !isEdit,
                style: textTheme.headline,
                decoration: InputDecoration(hintText: 'Заголовок'),
                validator: (val) {
                  return val.trim().isEmpty ? 'Обязательное поле' : null;
                },
                onSaved: (val) => _task = val,
              ),
              TextFormField(
                initialValue: isEdit ? widget.todo.note : '',
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(hintText: 'Примечание'),
                onSaved: (val) => _note = val,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEdit ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
