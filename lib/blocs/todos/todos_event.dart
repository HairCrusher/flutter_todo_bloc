import 'package:equatable/equatable.dart';
import 'package:todoapp/models/Todo.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosLoadEvent extends TodosEvent {}
class TodoAddEvent extends TodosEvent {
  final Todo todo;
  TodoAddEvent(this.todo);

  @override
  List<Object> get props => [todo];
}
class TodoRemoveEvent extends TodosEvent {
  final Todo todo;
  TodoRemoveEvent(this.todo);

  @override
  List<Object> get props => [todo];
}
class TodoUpdateEvent extends TodosEvent {
  final Todo todo;
  TodoUpdateEvent(this.todo);

  @override
  List<Object> get props => [todo];
}
class TodoClearCompletedEvent extends TodosEvent {}
class TodosToggleCompleteEvent extends TodosEvent {}