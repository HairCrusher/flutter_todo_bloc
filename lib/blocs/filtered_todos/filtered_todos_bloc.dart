import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todoapp/blocs/filtered_todos/filter.dart';
import 'package:todoapp/blocs/todos/bloc.dart';
import 'package:todoapp/models/Todo.dart';
import './bloc.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription _sub;

  FilteredTodosBloc(this.todosBloc) {
    _sub = todosBloc.listen((todosState) {
      if (todosState is TodosLoadSuccess) {
        add(TodosChangeEvent());
      }
    });
  }

  @override
  FilteredTodosState get initialState => todosBloc.state is TodosLoadSuccess
      ? FilteredTodosLoadSuccess(
          (todosBloc.state as TodosLoadSuccess).todos, TodosFilter.ShowAll)
      : FilteredTodosLoadInProgress();

  @override
  Stream<FilteredTodosState> mapEventToState(
    FilteredTodosEvent event,
  ) async* {
    if (event is FilterChangeEvent) {
      yield* _mapFilterChangeEventToState(event);
    } else if (event is TodosChangeEvent) {
      yield* _mapTodosChangeEventToState();
    }
  }

  Stream<FilteredTodosState> _mapFilterChangeEventToState(
      FilterChangeEvent event) async* {
    if (todosBloc.state is TodosLoadSuccess) {
      yield FilteredTodosLoadSuccess(
          filterTodos(
              (todosBloc.state as TodosLoadSuccess).todos, event.filter),
          event.filter);
    }
  }

  Stream<FilteredTodosState> _mapTodosChangeEventToState() async* {
    final filter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).filter
        : TodosFilter.ShowAll;

    yield FilteredTodosLoadSuccess(
        filterTodos((todosBloc.state as TodosLoadSuccess).todos, filter),
        filter);
  }

  List<Todo> filterTodos(List<Todo> todos, TodosFilter filter) {
    return todos.where((item) {
      switch (filter) {
        case TodosFilter.ShowAll:
          return true;

        case TodosFilter.Active:
          return !item.complete;

        case TodosFilter.Completed:
          return item.complete;
      }
      return false;
    }).toList();
  }

  @override
  Future<Function> close() {
    _sub.cancel();
    super.close();
  }
}
