import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/models/Todo.dart';
import 'package:todoapp/repositories/TodosRepo.dart';

import 'todos_event.dart';
import 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepo repo;

  TodosBloc({@required this.repo}) : assert(repo != null);

  @override
  TodosState get initialState => TodosLoadInProgress();

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is TodosLoadEvent) {
      yield* _mapTodosLoadEventToState();
    } else if (event is TodoAddEvent) {
      yield* _mapTodoAddEventToState(event);
    } else if (event is TodoUpdateEvent) {
      yield* _mapTodoUpdateEventToState(event);
    } else if (event is TodoRemoveEvent) {
      yield* _mapTodoRemoveEventToState(event);
    } else if (event is TodoClearCompletedEvent) {
      yield* _mapTodoClearCompletedEventToState();
    } else if (event is TodosToggleCompleteEvent) {
      yield* _mapTodosToggleCompleteEventToState();
    }
  }

  Stream<TodosState> _mapTodosLoadEventToState() async* {
    try {
      final List<Todo> todos = await repo.fetch();
      yield TodosLoadSuccess(todos);
    } catch (e) {
      print(e);
      yield TodosLoadFailure();
    }
  }

  Stream<TodosState> _mapTodoAddEventToState(TodoAddEvent event) async* {
    print(state);
    print(state is TodosLoadSuccess);
    if (state is TodosLoadSuccess) {
      final todo = await repo.put(event.todo);
      final List<Todo> updatedTodos =
          List.from((state as TodosLoadSuccess).todos)..add(todo);
      yield TodosLoadSuccess(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoUpdateEventToState(TodoUpdateEvent event) async* {
    if (state is TodosLoadSuccess) {
      repo.update(event.todo);
      final todos = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      yield TodosLoadSuccess(todos);
    }
  }

  Stream<TodosState> _mapTodoRemoveEventToState(TodoRemoveEvent event) async* {
    if (state is TodosLoadSuccess) {
      await repo.delete(event.todo.id);
      final todos = (state as TodosLoadSuccess)
          .todos
          .where((item) => item.id != event.todo.id)
          .toList();
      yield TodosLoadSuccess(todos);
    }
  }

  Stream<TodosState> _mapTodoClearCompletedEventToState() async* {
    if (state is TodosLoadSuccess) {
      final todos = (state as TodosLoadSuccess).todos.where((todo) => !todo.complete).toList();
      final todosRm = (state as TodosLoadSuccess).todos.where((todo) => todo.complete);

      for (final todo in todosRm) {
        await repo.delete(todo.id);
      }

      yield TodosLoadSuccess(todos);
    }
  }

  Stream<TodosState> _mapTodosToggleCompleteEventToState() async* {
    if (state is TodosLoadSuccess) {
      final bool allComplete = (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
      final todos = (state as TodosLoadSuccess).todos.map((todo) => todo.copyWith(complete: !allComplete)).toList();

      yield TodosLoadSuccess(todos);
    }
  }

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
