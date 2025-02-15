library eazy_router_annotation;

class GenerateRoute {
  final String? pathName;
  final bool isInitial;
  final bool canPop;
  final String transition;

  const GenerateRoute({
    this.pathName,
    this.isInitial = false,
    this.canPop = true,
    this.transition = RouteTransitions.adaptive,
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
