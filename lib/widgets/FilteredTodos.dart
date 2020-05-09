import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/filtered_todos/bloc.dart';
import 'package:todoapp/blocs/todos/bloc.dart';

import '../router.dart';
import 'LoadingIndicator.dart';
import 'TodoItem.dart';

class FilteredTodos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        builder: (BuildContext context, FilteredTodosState state) {
          if (state is FilteredTodosLoadSuccess) {
            final todos = state.todos;

            if (todos.length == 0) {
              return Center(
                child: Text('Заметки отсутствуют',
                    style: Theme.of(context).textTheme.body2),
              );
            }

            return ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {},
                children: todos.map((todo) =>
                    TodoItem(
                      key: Key('TodoItem_${todo.id}'),
                      todo: todo,
                      onDismissed: (dir) {
                        BlocProvider.of<TodosBloc>(context)
                            .add(TodoRemoveEvent(todo));
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Заметка удалена'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                              label: 'ОТМЕНИТЬ',
                              onPressed: () {
                                BlocProvider.of<TodosBloc>(context)
                                    .add(TodoAddEvent(todo));
                              }),
                        ));
                      },
                      onChanged: (bool value) {
                        BlocProvider.of<TodosBloc>(context).add(TodoUpdateEvent(
                            todo.copyWith(complete: !todo.complete)));
                      },
                      onTap: () {
                        Router.toEditTodo(context, (task, note) {
                          BlocProvider.of<TodosBloc>(context).add(TodoUpdateEvent(
                              todo.copyWith(task: task, note: note)));
                        }, todo);
                      },
                    )).toList()
            );
          } else if (state is FilteredTodosLoadInProgress) {
            return LoadingIndicator();
          } else {
            return Container();
          }
        });
  }
}
