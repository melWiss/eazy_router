import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_navigator.dart';
import 'package:flutter/widgets.dart';

class EazyRouterDelegate extends RouterDelegate<EazyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EazyRouteState> {
  final IEazyRouter router;
  EazyRouterDelegate(this.router) {
    router.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) => EazyRouterNavigator(
        router: router,
        key: navigatorKey,
      );

  @override
  Future<bool> popRoute() async {
    router.pop();
    notifyListeners();
    return true;
  }

  @override
  Future<void> setNewRoutePath(EazyRouteState configuration) async {
    router.goTo(configuration.toUri());
    notifyListeners();
  }

  @override
  EazyRouteState? get currentConfiguration =>
      EazyRouteState.fromUri(router.currentUri);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
