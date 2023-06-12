import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/route_info_parser.dart';

import 'package:todo_app/config/router_delegation.dart';
import 'package:todo_app/domain/use_cases/add_todo_use_case.dart';
import 'package:todo_app/domain/use_cases/mark_todo_as_completed_use_case.dart';
import 'package:todo_app/domain/use_cases/remove_todo_use_case.dart';
import 'package:todo_app/presentation/providers/todo_list_provider.dart';

import 'data/repositories/todo_repository.dart';
import 'domain/use_cases/get_todos_use_case.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<TodoRepository>(
        create: (_) => TodoRepositoryImpl(),
      ),
      Provider<GetTodosUseCase>(
        create: (context) => GetTodosUseCase(
          Provider.of<TodoRepository>(context, listen: false),
        ),
      ),
      Provider<RemoveTodoUseCase>(
        create: (context) => RemoveTodoUseCase(
          Provider.of<TodoRepository>(context, listen: false),
        ),
      ),
      Provider<AddTodoUseCase>(
        create: (context) => AddTodoUseCase(
          Provider.of<TodoRepository>(context, listen: false),
        ),
      ),
      Provider<MarkTodoAsCompletedUseCase>(
        create: (context) => MarkTodoAsCompletedUseCase(
          Provider.of<TodoRepository>(context, listen: false),
        ),
      ),
      Provider<TodoListProvider>(
        create: (context) => TodoListProvider(
          getTodosUseCase: Provider.of<GetTodosUseCase>(context, listen: false),
          removeTodoUseCase: Provider.of<RemoveTodoUseCase>(context, listen: false),
          markTodoAsCompletedUseCase: Provider.of<MarkTodoAsCompletedUseCase>(context, listen: false),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: "Todo App");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routeInformationParser: RouteInfoParser(),
      routerDelegate: RouterDelegation(),
      title: widget.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      )
    );
  }
}
