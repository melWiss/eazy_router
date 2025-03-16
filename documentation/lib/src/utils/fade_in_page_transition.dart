import 'package:flutter/material.dart';

class FadeInPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Constructs a page transition animation that slides the page up.
  const FadeInPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double>? secondaryAnimation,
    Widget child,
  ) {
    return _FadeInPageTransition(routeAnimation: animation, child: child);
  }
}

class _FadeInPageTransition extends StatelessWidget {
  _FadeInPageTransition({
    required Animation<double>
        routeAnimation, // The route's linear 0.0 - 1.0 animation.
    required this.child,
  }) : _opacityAnimation = routeAnimation.drive(_easeInTween);

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: child,
    );
  }
}
