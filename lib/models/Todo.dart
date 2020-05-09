import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final bool complete;
  final String task;
  final String note;

  Todo(this.task,
      {
        this.id,
        this.complete,
        this.note
      });

  static Todo fromJson(json) {
    return Todo(
      json['task'],
      id: json['id'],
      note: json['note'],
      complete: json['complete']
    );
  }

  Map<String, Object> toJson() => {
    'id': id,
    'task': task,
    'note': note,
    'complete': complete,
  };

  Todo copyWith ({String id, bool complete, String task, String note}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note
    );
  }

  @override
  List<Object> get props => [id, task, complete, note];

  @override
  String toString() => 'Todo {id:$id, complete:$complete, task:$task, note:$note}';


}