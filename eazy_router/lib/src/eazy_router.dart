import 'dart:async';

import 'package:eazy_router/src/eazy_route.dart';
import 'package:eazy_router/src/other/eazy_route_middleware.dart';
import 'package:flutter/widgets.dart';

abstract class IEazyRouter with ChangeNotifier {
  Map<String, EazyRoute Function(Map<String, String>? params)> get routes;
  IEazyRouter? get parent;
  void setInitialRoute(EazyRoute route);
  EazyRoute? get initialRoute;
  void setNotFoundRoute(EazyRoute route);
  void registerRoutes(
      Map<String, EazyRoute Function(Map<String, String>? params)> routes);
  Future<T?> push<T>(EazyRoute route);
  void pushRoutes(List<EazyRoute> routes);
  void replaceRoutes(List<EazyRoute> routes);
  void pop({int times = 1, dynamic data});
  void removeRoute(EazyRoute route, {bool notifyRootWidget = false});
  void removePageRoute(Page page, {bool notifyRootWidget = false});
  void removeRouteByName(String name, {bool notifyRootWidget = false});
  void popUntilTrue(bool Function(EazyRoute route) predicate);
  void goTo(Uri uri);
  bool hasRoute(String name);
  List<EazyRoute> get routeStack;
  Uri get currentUri;
  void setParentRouter(IEazyRouter? router);
}

class EazyRouter extends IEazyRouter {
  List<EazyRoute> _state = [];
  final List<Completer> _completersStack = [];
  EazyRoute? _initialRoute;
  EazyRoute? _notFoundRoute;
  final Map<String, EazyRoute Function(Map<String, String>? params)>
      _registeredRoutes = {};
  IEazyRouter? _parent;

  EazyRouter();

  @override
  Future<T?> push<T>(EazyRoute route) {
    if (_canNavigate(route)) {
      _state = List.from([..._state, route]);
      notifyListeners();
      Completer<T> completer = Completer();
      _completersStack.add(completer);
      return completer.future;
    }
    return Future.value(null);
  }

  bool _canNavigate(EazyRoute route) {
    var resolver = EazyRouterResolver(
      redirect: (newRouteStack) =>
          replaceRoutes(newRouteStack.map((e) => e as EazyRoute).toList()),
      goHome: () =>
          _initialRoute != null ? replaceRoutes([_initialRoute!]) : null,
      goNotFound: () => _notFoundRoute != null ? push(_notFoundRoute!) : null,
      push: (route) => push(route as EazyRoute),
    );
    for (var middleware in route.middlewares) {
      if (!middleware.onNavigation(resolver)) {
        return false;
      }
    }
    return true;
  }

  @override
  void pushRoutes(List<EazyRoute> routes) {
    for (var route in routes) {
      if (!_canNavigate(route)) return;
    }
    _state = List.from([..._state, ...routes]);
    notifyListeners();
  }

  @override
  void replaceRoutes(List<EazyRoute> routes) {
    for (var route in routes) {
      if (!_canNavigate(route)) return;
    }
    _state = routes;
    notifyListeners();
  }

  @override
  void pop({int times = 1, dynamic data}) {
    _state.removeRange(_state.length - times, _state.length);
    _state = List.from(_state);
    notifyListeners();
    if (_completersStack.isNotEmpty &&
        data.runtimeType == _completersStack.last.runtimeType) {
      _completersStack.last.complete(data);
      _completersStack.removeLast();
    }
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
  void removePageRoute(Page page, {bool notifyRootWidget = false}) {
    if (_state.any((element) =>
        element.page.name == page.name && element.page.key == page.key)) {
      var pageToRemove = _state.firstWhere((element) =>
          element.page.name == page.name && element.page.key == page.key);
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
        if (_canNavigate(routes[path]!(uri.queryParameters))) {
          _state.add(routes[path]!(uri.queryParameters));
        } else {
          return;
        }
      } else if (_notFoundRoute != null) {
        _state.add(_notFoundRoute!);
        break;
      }
    }
    if (_state.isEmpty) {
      if (_initialRoute != null && _canNavigate(_initialRoute!)) {
        _state.add(_initialRoute!);
      } else if (_canNavigate(routes.values.first(uri.queryParameters))) {
        _state.add(routes.values.first(uri.queryParameters));
      }
    }
    notifyListeners();
  }

  @override
  Uri get currentUri {
    String completePath = '';
    Map<String, String> params = {};
    for (int i = 0; i < _state.length; i++) {
      if (i == 0 && _state.first.isInitial || _state[i].isAnonymous) {
        continue;
      }
      completePath += '/${_state[i].page.name}';
      params.addAll((_state[i].queryParameters as Map<String, String>?) ?? {});
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
      Map<String, EazyRoute Function(Map<String, String>? params)> routes) {
    _registeredRoutes.addAll(routes);
  }

  @override
  Map<String, EazyRoute Function(Map<String, String>? params)> get routes =>
      _registeredRoutes;

  @override
  void setInitialRoute(EazyRoute route) {
    _initialRoute = route;
    _state.insert(0, route);
    notifyListeners();
  }

  @override
  void setNotFoundRoute(EazyRoute route) {
    _notFoundRoute = route;
  }

  @override
  IEazyRouter? get parent => _parent;

  @override
  void setParentRouter(IEazyRouter? router) {
    _parent = router;
  }

  @override
  EazyRoute? get initialRoute => _initialRoute;
}
