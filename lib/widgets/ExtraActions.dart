import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/todos/bloc.dart';

enum ExtraAction { ClearCompleted, ToggleCompleted }

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (BuildContext context, TodosState state) {
        if (state is TodosLoadSuccess) {
          final allComplete = state.todos.every((item) => item.complete);

          return PopupMenuButton(
            onSelected: (ExtraAction action) {
              switch (action) {
                case ExtraAction.ClearCompleted:
                  BlocProvider.of<TodosBloc>(context)
                      .add(TodoClearCompletedEvent());
                  break;
                case ExtraAction.ToggleCompleted:
                  BlocProvider.of<TodosBloc>(context)
                      .add(TodosToggleCompleteEvent());
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Очистить завершенные'),
                  value: ExtraAction.ClearCompleted,
                ),
                PopupMenuItem(
                  child: Text(allComplete
                      ? 'Пометить все как незавершенные'
                      : 'Пометить все как завершенные'),
                  value: ExtraAction.ToggleCompleted,
                )
              ];
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
