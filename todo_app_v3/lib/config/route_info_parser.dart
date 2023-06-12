import 'package:flutter/material.dart';
import 'package:todo_app/config/route_configuration.dart';
import 'package:todo_app/config/routes.dart';


class RouteInfoParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return RouteConfiguration.home();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'todos') {
        return RouteConfiguration.home();
      }
      if (uri.pathSegments[0] == 'error') {
        return RouteConfiguration.unknown();
      }
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'detail') {
        final id = int.tryParse(uri.pathSegments[1]);
        if (id != null) {
          return RouteConfiguration.detail(id: id);
        }
      }
    }

    return RouteConfiguration.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    if (configuration.isKnown) {
      if (configuration.route == Routes.todos) {
        return const RouteInformation(location: '/todos');
      }
      if (configuration.route == Routes.detail) {
        return RouteInformation(location: '/detail/${configuration.arguments['id']}');
      }
    }
    return const RouteInformation(location: '/error');
  }
}