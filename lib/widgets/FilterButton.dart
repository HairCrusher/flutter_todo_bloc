import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/filtered_todos/bloc.dart';
import 'package:todoapp/blocs/filtered_todos/filter.dart';
import 'package:todoapp/blocs/todos/bloc.dart';

class FilterButton extends StatelessWidget {

  TodosBloc todosBloc;
  bool get isFBtnVisible {
    if(todosBloc.state is TodosLoadSuccess) {
      return (todosBloc.state as TodosLoadSuccess).todos.length != 0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (BuildContext context, FilteredTodosState state) {
        final TodosFilter activeFilter = state is FilteredTodosLoadSuccess ? state.filter : TodosFilter.ShowAll;
        final defaultStyle = Theme.of(context).textTheme.body1;
        final activeStyle = Theme.of(context)
            .textTheme
            .body1
            .copyWith(color: Theme.of(context).accentColor);

        bool isEnabled;
        todosBloc = BlocProvider.of<TodosBloc>(context);
        if(todosBloc.state is TodosLoadSuccess) {
          isEnabled = (todosBloc.state as TodosLoadSuccess).todos.length != 0;
        } else {
          isEnabled = false;
        }

        return PopupMenuButton<TodosFilter>(
          icon: Icon(Icons.filter_list),
          enabled: isEnabled,
          onSelected: (filter) {
            BlocProvider.of<FilteredTodosBloc>(context).add(FilterChangeEvent(filter));
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text('Показать все'),
                value: TodosFilter.ShowAll,
                textStyle: activeFilter == TodosFilter.ShowAll ? activeStyle : defaultStyle,
              ),
              PopupMenuItem(
                child: Text('Показать активные'),
                value: TodosFilter.Active,
                textStyle: activeFilter == TodosFilter.Active ? activeStyle : defaultStyle,
              ),
              PopupMenuItem(
                child: Text('Показать выполненные'),
                value: TodosFilter.Completed,
                textStyle: activeFilter == TodosFilter.Completed ? activeStyle : defaultStyle,
              )
            ];
          },
        );
      },
    );
  }

}