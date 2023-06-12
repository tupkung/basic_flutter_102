import 'package:todo_app/config/routes.dart';


class RouteConfiguration {
  late Routes route;
  late Map<String, dynamic> arguments;

  RouteConfiguration({this.route = Routes.todos, Map<String, dynamic>? arguments}) {
    this.arguments = arguments ?? <String, dynamic>{};
  }

  RouteConfiguration.home() {
    route = Routes.todos;
    arguments = <String, dynamic>{};
  }

  RouteConfiguration.detail({required int id}) {
    route = Routes.detail;
    arguments = <String, dynamic>{'id': id};
  }

  RouteConfiguration.add() {
    route = Routes.add;
    arguments = <String, dynamic>{};
  }

  RouteConfiguration.unknown() {
    route = Routes.error;
    arguments = <String, dynamic>{};
  }

  bool get isKnown {
    return route != Routes.error;
  }
}