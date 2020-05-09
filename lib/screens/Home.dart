import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/filtered_todos/bloc.dart';
import 'package:todoapp/blocs/todos/bloc.dart';
import 'package:todoapp/models/Todo.dart';
import 'package:todoapp/widgets/ExtraActions.dart';
import 'package:todoapp/widgets/FilterButton.dart';
import 'package:todoapp/widgets/FilteredTodos.dart';
import 'package:todoapp/widgets/LoadingIndicator.dart';

import '../router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => FilteredTodosBloc(BlocProvider.of<TodosBloc>(context)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo app'),
          actions: <Widget>[
            FilterButton(),
            ExtraActions()
          ],
        ),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadSuccess) {
              return FilteredTodos();
            } else if (state is TodosLoadInProgress) {
              return LoadingIndicator();
            } else if (state is TodosLoadFailure) {
              return Center(
                child: Text(
                  'Ошибка во время загрузки!',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.red),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Router.toAddTodo(context, (task, note) {
              BlocProvider.of<TodosBloc>(context)
                  .add(TodoAddEvent(Todo(task, note: note)));
            });
          },
        ),
      ),
    );
  }
}
