import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_navigator.dart';
import 'package:eazy_router/src/other/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EazyRouterDelegate extends RouterDelegate<EazyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EazyRouteState> {
  EazyRouterDelegate();

  final Map<String, IEazyRouter> _routersMap = {
    rootRouterKey: EazyRouter(),
  };

  late IEazyRouter _currentRouter = rootRouter;

  void setCurrentRouter(IEazyRouter router) {
    _currentRouter = router;
  }

  IEazyRouter get currentRouter => _currentRouter;

  void registerRouter(IEazyRouter router, String routerKey) {
    _routersMap[routerKey] = router;
  }

  void unregisterRouter(String routerKey) {
    _routersMap.remove(routerKey);
  }

  IEazyRouter get rootRouter => _routersMap[rootRouterKey]!;

  @override
  Widget build(BuildContext context) => EazyRouterNavigator(
        navigatorKey: navigatorKey,
        builder: (navigator, router) => navigator,
        router: rootRouter,
      );

  @override
  Future<bool> popRoute() async {
    _currentRouter.pop();
    notifyListeners();
    return true;
  }

  @override
  Future<void> setNewRoutePath(EazyRouteState configuration) async {
    List<String> pathSegments = configuration.toUri().pathSegments;
    IEazyRouter? localRouter;
    for (var path in pathSegments) {
      await Future.delayed(Durations.short1);
      var routeFromPath = rootRouter.routes[path]?.call(configuration.params);
      localRouter = _routersMap[routeFromPath?.parent] ?? rootRouter;
      if (routeFromPath == null) {
        if (localRouter.notFoundRoute != null) {
          localRouter.push(localRouter.notFoundRoute!);
        }
        break;
      }
      if ((localRouter.initialRoute?.page.name != routeFromPath.page.name ||
              !mapEquals(
                localRouter.initialRoute?.queryParameters,
                routeFromPath.queryParameters,
              )) &&
          (localRouter.currentRoute?.page.name != routeFromPath.page.name ||
              !mapEquals(
                localRouter.currentRoute?.queryParameters,
                routeFromPath.queryParameters,
              ))) {
        localRouter.push(routeFromPath);
      }
    }
    if (localRouter != null) {
      setCurrentRouter(localRouter);
    }
  }

  @override
  EazyRouteState? get currentConfiguration =>
      _oldConfiguration = EazyRouteState.fromUri(_currentRouter.currentUri);
  EazyRouteState? _oldConfiguration;

  void refresh() {
    var newConfiguration = EazyRouteState.fromUri(_currentRouter.currentUri);
    if (_oldConfiguration != newConfiguration) {
      _oldConfiguration = newConfiguration;
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    }
  }

  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: rootRouterKey);

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
