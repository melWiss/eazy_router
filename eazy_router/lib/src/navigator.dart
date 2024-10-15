import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

abstract class IEazyRouterHandler with ChangeNotifier {
  Map<String, EazyRoute Function(Map<String, String> params)> get routes;
  void setInitialRoute(EazyRoute route);
  void registerRoutes(
      Map<String, EazyRoute Function(Map<String, String> params)> routes);
  void push(EazyRoute route);
  void pushRoutes(List<EazyRoute> routes);
  void replaceRoutes(List<EazyRoute> routes);
  void pop({int times = 1});
  void removeRoute(EazyRoute route, {bool notifyRootWidget = false});
  void removeRouteByName(String name, {bool notifyRootWidget = false});
  void popUntilTrue(bool Function(EazyRoute route) predicate);
  void goTo(Uri uri);
  bool hasRoute(String name);
  List<EazyRoute> get routeStack;
  Uri get currentUri;
}

class EazyRouterHandler extends IEazyRouterHandler {
  List<EazyRoute> _state = [];
  EazyRoute? _initialRoute;
  final Map<String, EazyRoute Function(Map<String, String> params)>
      _registeredRoutes = {};

  // create a singleton constructor
  static EazyRouterHandler? _instance;

  EazyRouterHandler._internal();

  factory EazyRouterHandler() {
    return _instance ??= EazyRouterHandler._internal();
  }

  @override
  void push(EazyRoute route) {
    _state = List.from([..._state, route]);
    notifyListeners();
  }

  @override
  void pushRoutes(List<EazyRoute> routes) {
    _state = List.from([..._state, ...routes]);
    notifyListeners();
  }

  @override
  void replaceRoutes(List<EazyRoute> routes) {
    _state = routes;
    notifyListeners();
  }

  @override
  void pop({int times = 1}) {
    _state.removeRange(_state.length - times, _state.length);
    _state = List.from(_state);
    notifyListeners();
  }

  @override
  void popUntilTrue(bool Function(EazyRoute route) predicate) {
    while (!predicate(_state.last)) {
      _state.removeLast();
    }
    _state = List.from(_state);
    notifyListeners();
  }

  @override
  void removeRoute(EazyRoute route, {bool notifyRootWidget = false}) {
    if (_state.contains(route)) {
      _state.remove(route);
      if (notifyRootWidget) {
        _state = List.from(_state);
        notifyListeners();
      }
    }
  }

  @override
  void removeRouteByName(String name, {bool notifyRootWidget = false}) {
    if (_state.any((element) => element.page.name == name)) {
      var pageToRemove =
          _state.firstWhere((element) => element.page.name == name);
      _state.remove(pageToRemove);
      if (notifyRootWidget) {
        _state = List.from(_state);
        notifyListeners();
      }
    }
  }

  @override
  bool hasRoute(String name) =>
      _state.any((element) => element.page.name == name);

  @override
  void goTo(Uri uri) {
    _state = List.empty(growable: true);
    for (var path in uri.pathSegments) {
      if (routes[path] != null) {
        _state.add(routes[path]!(uri.queryParameters));
      }
    }
    if (_state.isEmpty) {
      if (_initialRoute != null) {
        _state.add(_initialRoute!);
      } else {
        _state.add(routes.values.first(uri.queryParameters));
      }
    }
    notifyListeners();
  }

  @override
  Uri get currentUri {
    String completePath = '';
    Map<String, String> params = {};
    for (var route in _state) {
      completePath += '/${route.page.name}';
      params.addAll((route.queryParameters as Map<String, String>?) ?? {});
    }
    return Uri(
      path: completePath,
      queryParameters: params,
    );
  }

  @override
  List<EazyRoute> get routeStack => _state;

  @override
  void registerRoutes(
      Map<String, EazyRoute Function(Map<String, String> params)> routes) {
    _registeredRoutes.addAll(routes);
  }

  @override
  Map<String, EazyRoute Function(Map<String, String> params)> get routes =>
      _registeredRoutes;

  @override
  void setInitialRoute(EazyRoute route) {
    _initialRoute = route;
    _state.insert(0, route);
    notifyListeners();
  }
}

class EazyRouterNavigator extends StatelessWidget {
  const EazyRouterNavigator({
    required IEazyRouterHandler navigatorHandler,
    this.navigatorKey,
    super.key,
  }) : _navigatorHandler = navigatorHandler;

  final IEazyRouterHandler _navigatorHandler;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    EazyRouterNavigatorContext._navigatorHandler = _navigatorHandler;
    return ChangeNotifierProvider<IEazyRouterHandler>.value(
      value: _navigatorHandler,
      builder: (_, __) => ListenableBuilder(
        listenable: _navigatorHandler,
        child: Navigator(
          pages: _navigatorHandler.routeStack
              .map<Page>(
                (r) => r.page,
              )
              .toList(),
          key: navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name != null &&
                _navigatorHandler.hasRoute(settings.name!)) {
              return _navigatorHandler
                  .routes[settings.name]!
                      (settings.arguments as Map<String, String>)
                  .page
                  .createRoute(context);
            }
            return _navigatorHandler.routes.values
                .first(settings.arguments as Map<String, String>)
                .page
                .createRoute(context);
          },
          onDidRemovePage: (page) {
            _navigatorHandler.removeRouteByName(page.name!,
                notifyRootWidget: true);
          },
        ),
        builder: (context, child) {
          if (child == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return child;
        },
      ),
    );
  }
}

extension EazyRouterNavigatorContext on BuildContext {
  static late IEazyRouterHandler _navigatorHandler;

  void push(EazyRoute route) => _navigatorHandler.push(route);
  void pushRoutes(List<EazyRoute> routes) =>
      _navigatorHandler.pushRoutes(routes);
  void replaceRoutes(List<EazyRoute> routes) =>
      _navigatorHandler.replaceRoutes(routes);
  void pop({int times = 1}) => _navigatorHandler.pop(times: times);
  void removeRoute(EazyRoute route, {bool notifyRootWidget = false}) =>
      _navigatorHandler.removeRoute(route, notifyRootWidget: notifyRootWidget);
  void removeRouteByName(String name, {bool notifyRootWidget = false}) =>
      _navigatorHandler.removeRouteByName(
        name,
        notifyRootWidget: notifyRootWidget,
      );
  void popUntilTrue(bool Function(EazyRoute route) predicate) =>
      _navigatorHandler.popUntilTrue(predicate);
  bool hasRoute(String name) => _navigatorHandler.hasRoute(name);
  List<EazyRoute> get routeSack => _navigatorHandler.routeStack;
  IEazyRouterHandler get router => _navigatorHandler;
}

abstract class EazyRoute {
  Map<String, String> get queryParameters;
  Page get page;
}
