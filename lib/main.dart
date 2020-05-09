import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/todos/bloc.dart';
import 'package:todoapp/repositories/TodosRepo.dart';
import 'package:todoapp/router.dart';
import 'package:todoapp/screens/Home.dart';

void main() => runApp(
  BlocProvider<TodosBloc>(
    create: (context) => TodosBloc(repo: TodosRepo())..add(TodosLoadEvent()),
    child: App(),
  )
);

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}