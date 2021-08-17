import 'dart:async';

import 'package:modular_core/modular_core.dart';
import 'package:modular_core/src/di/bind_context.dart';
import 'package:shelf/shelf.dart' hide Middleware;

typedef HandlerWithArgs = FutureOr<Response> Function(Request request, ModularArguments args);

class Route extends ModularRoute {
  final Function? handler;
  Route._({
    this.handler,
    required String name,
    String parent = '',
    List<ModularRoute> children = const [],
    List<Middleware> middlewares = const [],
    Uri? uri,
    Map<String, ModularRoute>? routeMap,
    Map<Type, BindContext> bindContextEntries = const {},
  }) : super(
          name: name,
          parent: parent,
          children: children,
          middlewares: middlewares,
          routeMap: routeMap,
          uri: uri ?? Uri.parse('/'),
          bindContextEntries: bindContextEntries,
        );

  factory Route.get(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: '$name@GET',
      middlewares: middlewares,
    );
  }

  factory Route.post(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: '$name@POST',
      middlewares: middlewares,
    );
  }

  factory Route.delete(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: '$name@DELETE',
      middlewares: middlewares,
    );
  }
  factory Route.path(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: '$name@PATH',
      middlewares: middlewares,
    );
  }

  factory Route.put(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: '$name@PUT',
      middlewares: middlewares,
    );
  }

  factory Route.resource(
    String name, {
    required List<ModularRoute> children,
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      name: name,
      children: children,
      middlewares: middlewares,
    );
  }

  factory Route.module(String name, {required Module module, List<Middleware> middlewares = const []}) {
    final route = Route._(name: name, middlewares: middlewares);
    return route.addModule(name, module: module) as Route;
  }

  @override
  Route copyWith({
    Handler? handler,
    String? name,
    List<Middleware>? middlewares,
    List<ModularRoute>? children,
    String? parent,
    Uri? uri,
    Map<String, ModularRoute>? routeMap,
    Map<Type, BindContext>? bindContextEntries,
  }) {
    return Route._(
      handler: handler ?? this.handler,
      name: name ?? this.name,
      middlewares: middlewares ?? this.middlewares,
      children: children ?? this.children,
      parent: parent ?? this.parent,
      uri: uri ?? uri,
      routeMap: routeMap ?? routeMap,
      bindContextEntries: bindContextEntries ?? this.bindContextEntries,
    );
  }
}
