import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/src/other/anonymous_eazy_route.dart';
import 'package:flutter/material.dart';

class EazyNavigator extends Navigator {
  const EazyNavigator({
    super.key,
    super.pages = const <Page<dynamic>>[],
    @Deprecated(
      'Use onDidRemovePage instead. '
      'super feature was deprecated after v3.16.0-17.0.pre.',
    )
    super.onPopPage,
    super.initialRoute,
    super.onGenerateInitialRoutes = Navigator.defaultGenerateInitialRoutes,
    super.onGenerateRoute,
    super.onUnknownRoute,
    super.transitionDelegate = const DefaultTransitionDelegate<dynamic>(),
    super.reportsRouteUpdateToEngine = false,
    super.clipBehavior = Clip.hardEdge,
    super.observers = const <NavigatorObserver>[],
    super.requestFocus = true,
    super.restorationScopeId,
    super.routeTraversalEdgeBehavior = kDefaultRouteTraversalEdgeBehavior,
    super.onDidRemovePage,
  });

  @override
  NavigatorState createState() => _EazyNavigatorState();
}

class _EazyNavigatorState extends NavigatorState {
  @override
  Future<T?> push<T extends Object?>(Route<T> route) {
    if (context.router != null) {
      return context.router!.push(AnonymousEazyRoute(route: route));
    }
    return super.push(route);
  }
}
