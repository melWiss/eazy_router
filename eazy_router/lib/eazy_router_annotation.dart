library eazy_router_annotation;

import 'package:eazy_router/src/other/eazy_route_guard.dart';

class GenerateRoute {
  final String? pathName;
  final bool isInitial;
  final bool isNotFoundRoute;
  final bool canPop;
  final bool isAnonymous;
  final String transition;
  final List<EazyRouteGuard> guards;

  const GenerateRoute({
    this.pathName,
    this.isInitial = false,
    this.canPop = true,
    this.isAnonymous = false,
    this.transition = RouteTransitions.adaptive,
    this.isNotFoundRoute = false,
    this.guards = const [],
  });
}

class RegisterRoutes {
  const RegisterRoutes();
}

abstract class RouteTransitions {
  static const String adaptive = 'AdaptivePage';
  static const String material = 'MaterialPage';
  static const String cupertino = 'CupertinoPage';
  static const String bottomsheet = 'BottomSheetPage';
  static const String dialog = 'DialogPage';
}
