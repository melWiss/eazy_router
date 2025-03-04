import 'package:eazy_router/src/abstract_eazy_route.dart';

abstract class EazyRouteGuard {
  const EazyRouteGuard();
  bool onNavigation(EazyRouterResolver resolver);
}

class EazyRouterResolver {
  final void Function(List<AbstractEazyRoute> newRouteStack) redirect;
  final void Function(AbstractEazyRoute route) push;
  final void Function() goHome;
  final void Function() goNotFound;

  EazyRouterResolver({
    required this.redirect,
    required this.push,
    required this.goHome,
    required this.goNotFound,
  });
}
