import 'package:eazy_router/src/eazy_route.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_configuration.dart';
import 'package:eazy_router/src/eazy_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class EazyRouterNavigator extends StatefulWidget {
  final IEazyRouter router;
  final GlobalKey<NavigatorState>? navigatorKey;
  final EazyRoute? initialRoute;
  final EazyRoute? notFoundRoute;

  const EazyRouterNavigator({
    super.key,
    this.initialRoute,
    this.notFoundRoute,
    this.navigatorKey,
    required this.router,
  });

  @override
  State<EazyRouterNavigator> createState() => _EazyRouterNavigatorState();
}

class _EazyRouterNavigatorState extends State<EazyRouterNavigator> {
  void _updateRootRouter() {
    (Router.of(context).routerDelegate as EazyRouterDelegate).refresh();
  }

  @override
  void initState() {
    widget.router.addListener(_updateRootRouter);
    super.initState();
  }

  @override
  void dispose() {
    widget.router.removeListener(_updateRootRouter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.router.setParentRouter(context.router);
    if (widget.initialRoute != null) {
      widget.router.setInitialRoute(widget.initialRoute!);
    }
    if (widget.notFoundRoute != null) {
      widget.router.setInitialRoute(widget.notFoundRoute!);
    }
    return ChangeNotifierProvider<IEazyRouter>.value(
      value: widget.router,
      builder: (_, __) => ListenableBuilder(
        listenable: widget.router,
        builder: (context, child) {
          return Navigator(
            key: widget.navigatorKey,
            pages: widget.router.routeStack
                .map<Page>(
                  (r) => r.page,
                )
                .toList(),
            onGenerateRoute: (settings) {
              if (settings.name != null &&
                  widget.router.hasRoute(settings.name!)) {
                return widget
                    .router
                    .routes[settings.name]!
                        (settings.arguments as Map<String, String>)
                    .page
                    .createRoute(context);
              } else if (widget.router.initialRoute != null) {
                return widget.router.initialRoute!.page.createRoute(context);
              } else if (widget.router.routes.isNotEmpty) {
                return widget.router.routes.values
                    .first(settings.arguments as Map<String, String>?)
                    .page
                    .createRoute(context);
              }
              return null;
            },
            onDidRemovePage: (page) {
              widget.router.removePageRoute(page, notifyRootWidget: true);
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
