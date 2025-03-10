import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_navigator.dart';
import 'package:eazy_router/src/other/constants.dart';
import 'package:flutter/widgets.dart';

class EazyRouterDelegate extends RouterDelegate<EazyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EazyRouteState> {
  final Map<String, IEazyRouter> _routersMap = {
    rootRouterKey: EazyRouter(),
  };
  EazyRouterDelegate();

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
    IEazyRouter.currentRouter?.pop();
    notifyListeners();
    return true;
  }

  @override
  Future<void> setNewRoutePath(EazyRouteState configuration) async {
    rootRouter.goTo(configuration.toUri());
    notifyListeners();
  }

  @override
  EazyRouteState? get currentConfiguration =>
      _oldConfiguration = EazyRouteState.fromUri(rootRouter.currentUri);
  EazyRouteState? _oldConfiguration;

  void refresh() {
    var newConfiguration = EazyRouteState.fromUri(rootRouter.currentUri);
    if (_oldConfiguration != newConfiguration) {
      _oldConfiguration = newConfiguration;
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    }
  }

  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: rootRouterKey);

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
