import 'package:equatable/equatable.dart';
import 'package:todoapp/blocs/filtered_todos/filter.dart';
import 'package:todoapp/models/Todo.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> todos;
  final TodosFilter filter;

  FilteredTodosLoadSuccess(this.todos, this.filter);

  @override
  List<Object> get props => [todos, filter];
}
