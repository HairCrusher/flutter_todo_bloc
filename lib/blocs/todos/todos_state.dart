import 'package:equatable/equatable.dart';
import 'package:todoapp/models/Todo.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  TodosLoadSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodosLoadFailure extends TodosState {}
