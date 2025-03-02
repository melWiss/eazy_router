import 'package:eazy_router/src/eazy_route.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class EazyRouterNavigator extends StatelessWidget {
  final IEazyRouter router;
  final EazyRoute? initialRoute;
  final EazyRoute? notFoundRoute;

  const EazyRouterNavigator({
    super.key,
    this.initialRoute,
    this.notFoundRoute,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    router.setParentRouter(context.router);
    if (initialRoute != null) {
      router.setInitialRoute(initialRoute!);
    }
    if (notFoundRoute != null) {
      router.setInitialRoute(notFoundRoute!);
    }
    return ChangeNotifierProvider<IEazyRouter>.value(
      value: router,
      builder: (_, __) => ListenableBuilder(
        listenable: router,
        builder: (context, child) {
          IEazyRouter.currentRouter = router;
          return Navigator(
            pages: router.routeStack
                .map<Page>(
                  (r) => r.page,
                )
                .toList(),
            onGenerateRoute: (settings) {
              if (settings.name != null && router.hasRoute(settings.name!)) {
                return router
                    .routes[settings.name]!
                        (settings.arguments as Map<String, String>)
                    .page
                    .createRoute(context);
              } else if (router.initialRoute != null) {
                return router.initialRoute!.page.createRoute(context);
              } else if (router.routes.isNotEmpty) {
                return router.routes.values
                    .first(settings.arguments as Map<String, String>?)
                    .page
                    .createRoute(context);
              }
              return null;
            },
            onDidRemovePage: (page) {
              router.removePageRoute(page, notifyRootWidget: true);
            },
          );
        },
      ),
    );
  }
}

extension EazyRouterNavigatorContext on BuildContext {
  IEazyRouter? get router =>
      findAncestorWidgetOfExactType<EazyRouterNavigator>()?.router;
  void showSnackBar(SnackBar snackBar,
      {AnimationStyle? snackBarAnimationStyle}) {
    EazyRouterConfiguration.instance.scaffoldMessengerKey.currentState
        ?.showSnackBar(snackBar,
            snackBarAnimationStyle: snackBarAnimationStyle);
  }
}
