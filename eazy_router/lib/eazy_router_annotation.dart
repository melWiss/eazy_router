import 'package:eazy_router/src/other/eazy_route_guard.dart';

class GenerateRoute {
  final String? pathName;
  final String? parent;
  final bool isInitial;
  final bool isNotFoundRoute;
  final bool canPop;
  final bool isAnonymous;

  /// Only available for bottom sheets transition
  final bool showDragHandle;
  final String transition;
  final List<EazyRouteGuard> guards;

  const GenerateRoute({
    this.pathName,
    this.isInitial = false,
    this.canPop = true,
    this.isAnonymous = false,
    @Deprecated('Pelase use GenerateBottomSheetRoute annotation instead')
    this.transition = RouteTransitions.adaptive,
    this.isNotFoundRoute = false,
    this.guards = const [],
    this.parent,
    this.showDragHandle = false,
  });
}

class GenerateBottomSheetRoute {
  final String? pathName;
  final String? parent;
  final bool canPop;
  final bool isAnonymous;
  final bool showDragHandle;
  final List<EazyRouteGuard> guards;
  final bool isScrollControlled;
  final double minChildSize;
  final double maxChildSize;
  final double initialChildSize;
  const GenerateBottomSheetRoute({
    this.pathName,
    this.canPop = true,
    this.isAnonymous = true,
    this.guards = const [],
    this.parent,
    this.showDragHandle = false,
    this.isScrollControlled = false,
    this.minChildSize = 0.25,
    this.initialChildSize = 0.5,
    this.maxChildSize = 1.0,
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
