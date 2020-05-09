import 'package:equatable/equatable.dart';
import 'package:todoapp/blocs/filtered_todos/filter.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class TodosChangeEvent extends FilteredTodosEvent {}
class FilterChangeEvent extends FilteredTodosEvent {
  final TodosFilter filter;

  FilterChangeEvent(this.filter);
}