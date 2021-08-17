import 'package:modular_core/modular_core.dart';
import 'package:modular_core/src/di/bind_context.dart';
import 'package:modular_core/src/route/modular_key.dart';

import 'modular_route.dart';
import 'route_context.dart';

class CustomRoute extends ModularRoute {
  final dynamic data;

  CustomRoute({
    required String name,
    this.data,
    String parent = '',
    String schema = '',
    List<ModularRoute> children = const [],
    Uri? uri,
    List<Middleware> middlewares = const [],
    Map<ModularKey, ModularRoute>? routeMap,
    Map<Type, BindContext> bindContextEntries = const {},
  }) : super(
          name: name,
          schema: schema,
          children: children,
          uri: uri ?? Uri.parse('/'),
          middlewares: middlewares,
          parent: parent,
          routeMap: routeMap,
          bindContextEntries: bindContextEntries,
        );

  factory CustomRoute.module(String name, {required RouteContext module, List<Middleware> middlewares = const []}) {
    final route = CustomRoute(name: name, middlewares: middlewares);
    return route.addModule(name, module: module) as CustomRoute;
  }

  @override
  ModularRoute copyWith({
    String? name,
    List<Middleware>? middlewares,
    String? parent,
    String? schema,
    List<ModularRoute>? children,
    Uri? uri,
    Map<ModularKey, ModularRoute>? routeMap,
    Map<Type, BindContext>? bindContextEntries,
  }) {
    return CustomRoute(
      data: data,
      name: name ?? this.name,
      children: children ?? this.children,
      middlewares: middlewares ?? this.middlewares,
      uri: uri ?? this.uri,
      schema: schema ?? this.schema,
      routeMap: routeMap ?? this.routeMap,
      parent: parent ?? this.parent,
      bindContextEntries: bindContextEntries ?? this.bindContextEntries,
    );
  }
}
