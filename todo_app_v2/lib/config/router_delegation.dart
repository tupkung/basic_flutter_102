import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/route_configuration.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/add_todo_use_case.dart';
import 'package:todo_app/domain/use_cases/mark_todo_as_completed_use_case.dart';
import 'package:todo_app/domain/use_cases/remove_todo_use_case.dart';
import 'package:todo_app/presentation/screens/todo_add_screen.dart';
import 'package:todo_app/presentation/screens/todo_list_screen.dart';

import 'package:todo_app/domain/use_cases/get_todos_use_case.dart';

class RouterDelegation extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  final GlobalKey<NavigatorState> navigatorKey;


  RouterDelegation() : navigatorKey = GlobalKey<NavigatorState>() {
    _configuration = RouteConfiguration.home();
  }

  RouteConfiguration _configuration = RouteConfiguration.home();

  @override
  RouteConfiguration? get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onPopPage: (route, result) {
          return _handlePopPage(route, result);
        },
        pages: [
          MaterialPage(
              key: const ValueKey('TodoListScreen'),
              child: TodoListScreen(
                getTodosUseCase: Provider.of<GetTodosUseCase>(context, listen: false),
                removeTodoUseCase: Provider.of<RemoveTodoUseCase>(context, listen: false),
                markTodoAsCompletedUseCase: Provider.of<MarkTodoAsCompletedUseCase>(context, listen: false),
                onRemoveTodo: (id) {
                  _configuration = RouteConfiguration.home();
                  notifyListeners();
                },
                onAddTodo: () {
                  _configuration = RouteConfiguration.add();
                  notifyListeners();
                },
                onMarkTodoAsCompleted: (id) {
                  _configuration = RouteConfiguration.home();
                  notifyListeners();
                },
              )),
          if (_configuration.route == Routes.add)
            MaterialPage(
              key: const ValueKey('TodoAddScreen'),
              child: TodoAddScreen(
                addTodoUseCase: Provider.of<AddTodoUseCase>(context, listen: false),
                onAddTodo: () {
                  _configuration = RouteConfiguration.home();
                  notifyListeners();
                },
              ),
            ),
        ]);
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    if (configuration.isKnown) {
      _configuration = configuration;
      notifyListeners();
    }
  }

  bool _handlePopPage(Route route, result) {
    Page page = route.settings as Page;
    if (page.key == const ValueKey('TodoListScreen')) {
      return false;
    }

    route.didPop(result);

    if (page.key == const ValueKey('TodoAddScreen')) {
      _configuration = RouteConfiguration.home();
      notifyListeners();
      return true;
    }

    return false;
  }
}
