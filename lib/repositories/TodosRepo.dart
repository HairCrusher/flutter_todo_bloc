import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todoapp/models/Todo.dart';

class TodosRepo {
  final String tag = 'v1';
  final Future<Directory> getDirectory = getApplicationDocumentsDirectory();

  Future<List<Todo>> fetch() async {
    final file = await _getLocalFile();

    if(file.lengthSync() == 0) return [];

    final str = file.readAsStringSync();
    final json = JsonDecoder().convert(str);

    return json.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  }

  Future<Todo> put(Todo todo) async {
    Todo _todo = todo.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      complete: false
    );

    final updatedTodos = await fetch()..add(_todo);
    await _save(updatedTodos);

    return _todo;
  }

  Future<void> delete(String id) async {
    List<Todo> todos = await fetch();

    final updatedTodos = todos.where((todo) => todo.id != id).toList();
    await _save(updatedTodos);
  }

  Future<void> update(Todo todo) async {
    List<Todo> todos = await fetch();

    final updatedTodos = todos.map((item) => item.id == todo.id ? todo : item).toList();

    await _save(updatedTodos);
  }



  Future<void> _save(List<Todo> todos) async {
    print('_SAVE');
    print(todos);
    final file = await _getLocalFile();

    file.writeAsStringSync(JsonEncoder().convert(todos));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory;

    final file = File('${dir.path}/todosStorage_$tag');

    if(!file.existsSync()) {
      file.createSync();
    }

    return file;
  }

  Future<void> clean() async {
    final file = await _getLocalFile();

    return file.deleteSync();
  }

}