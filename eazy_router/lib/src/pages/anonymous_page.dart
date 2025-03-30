import 'package:flutter/material.dart';

class AnonymousPage<T> extends Page<T> {
  const AnonymousPage({
    super.key,
    super.name,
    super.arguments,
    super.canPop,
    required this.route,
  });

  final Route<T> route;

  @override
  Route<T> createRoute(BuildContext context) {
    if (route is MaterialPageRoute<T>) {
      final materialRoute = route as MaterialPageRoute<T>;
      return MaterialPageRoute<T>(
        settings: this,
        builder: materialRoute.builder,
        fullscreenDialog: materialRoute.fullscreenDialog,
        maintainState: materialRoute.maintainState,
      );
    } else if (route is DialogRoute<T>) {
      final dialogRoute = route as DialogRoute<T>;
      return DialogRoute<T>(
        settings: this,
        context: context,
        builder: (context) {
          // Use the dialogRoute's buildPage method with dummy animations.
          return dialogRoute.buildPage(
            context,
            const AlwaysStoppedAnimation(0),
            const AlwaysStoppedAnimation(0),
          );
        },
        barrierColor: dialogRoute.barrierColor,
        barrierDismissible: dialogRoute.barrierDismissible,
        barrierLabel: dialogRoute.barrierLabel,
      );
    } else {
      final pageRoute = route as PageRoute<T>;
      return PageRouteBuilder<T>(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) =>
            pageRoute.buildPage(context, animation, secondaryAnimation),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child, // No transition
      );
    }
  }
}