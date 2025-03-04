import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_navigator.dart';
import 'package:flutter/widgets.dart';

class EazyRouterDelegate extends RouterDelegate<EazyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EazyRouteState> {
  final IEazyRouter router;
  EazyRouterDelegate(this.router);

  @override
  Widget build(BuildContext context) => EazyRouterNavigator(
        router: router,
        navigatorKey: navigatorKey,
      );

  @override
  Future<bool> popRoute() async {
    IEazyRouter.currentRouter?.pop();
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
      _oldConfiguration = EazyRouteState.fromUri(router.currentUri);
  EazyRouteState? _oldConfiguration;

  void refresh() {
    var newConfiguration = EazyRouteState.fromUri(router.currentUri);
    if (_oldConfiguration != newConfiguration) {
      _oldConfiguration = newConfiguration;
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    }
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
