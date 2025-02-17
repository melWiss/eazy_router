import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class EazyRouterNavigator extends StatelessWidget {
  final IEazyRouter router;
  final GlobalKey<NavigatorState>? navigatorKey;

  const EazyRouterNavigator({
    super.key,
    required this.router,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IEazyRouter>.value(
      value: router,
      builder: (_, __) => ListenableBuilder(
        listenable: router,
        child: Navigator(
          pages: router.routeStack
              .map<Page>(
                (r) => r.page,
              )
              .toList(),
          key: navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name != null && router.hasRoute(settings.name!)) {
              return router
                  .routes[settings.name]!
                      (settings.arguments as Map<String, String>)
                  .page
                  .createRoute(context);
            }
            return router.routes.values
                .first(settings.arguments as Map<String, String>)
                .page
                .createRoute(context);
          },
          onDidRemovePage: (page) {
            router.removeRouteByName(page.name!, notifyRootWidget: true);
          },
        ),
        builder: (context, child) {
          if (child == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return child;
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
