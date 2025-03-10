import 'package:eazy_router/src/eazy_route.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_configuration.dart';
import 'package:eazy_router/src/eazy_router_delegate.dart';
import 'package:eazy_router/src/other/constants.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class EazyRouterNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String routerKey;
  final EazyRoute? initialRoute;
  final EazyRoute? notFoundRoute;
  final IEazyRouter? router;
  final void Function(IEazyRouter router, EazyRoute currentRoute)? listener;
  final void Function(IEazyRouter router)? onRouterCreation;
  final Widget Function(Widget navigator, IEazyRouter router) builder;

  const EazyRouterNavigator({
    required this.builder,
    this.initialRoute,
    this.notFoundRoute,
    this.navigatorKey,
    this.routerKey = rootRouterKey,
    this.listener,
    this.router,
    this.onRouterCreation,
    super.key,
  });

  @override
  State<EazyRouterNavigator> createState() => _EazyRouterNavigatorState();
}

class _EazyRouterNavigatorState extends State<EazyRouterNavigator> {
  late final IEazyRouter router = widget.router ?? EazyRouter();
  void _updateRootRouter() {
    (Router.of(context).routerDelegate as EazyRouterDelegate).refresh();
  }

  void _callListener() {
    widget.listener?.call(router, router.currentRoute!);
  }

  @override
  void initState() {
    if (router != widget.router && widget.router != null) {
      router.registerRoutes(widget.router!.routes);
    }
    widget.onRouterCreation?.call(router);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (Router.of(context).routerDelegate as EazyRouterDelegate)
          .registerRouter(router, widget.routerKey);
    });
    router.addListener(_updateRootRouter);
    router.addListener(_callListener);
    super.initState();
  }

  @override
  void dispose() {
    (Router.of(context).routerDelegate as EazyRouterDelegate)
        .unregisterRouter(widget.routerKey);
    router.removeListener(_updateRootRouter);
    router.removeListener(_callListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    router.setParentRouter(context.router);
    if (widget.initialRoute != null) {
      router.setInitialRoute(widget.initialRoute!);
    }
    if (widget.notFoundRoute != null) {
      router.setNotFoundRoute(widget.notFoundRoute!);
    }
    return ListenableBuilder(
      listenable: router,
      builder: (context, child) {
        return widget.builder(
          Navigator(
            key: widget.navigatorKey,
            onUnknownRoute: (_) =>
                widget.notFoundRoute?.page.createRoute(context) ??
                router.notFoundRoute?.page.createRoute(context),
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
          ),
          router,
        );
      },
    );
  }
}

extension EazyRouterNavigatorContext on BuildContext {
  IEazyRouter? get router =>
      findAncestorStateOfType<_EazyRouterNavigatorState>()?.router;
  void showSnackBar(SnackBar snackBar,
      {AnimationStyle? snackBarAnimationStyle}) {
    EazyRouterConfiguration.instance.scaffoldMessengerKey.currentState
        ?.showSnackBar(snackBar,
            snackBarAnimationStyle: snackBarAnimationStyle);
  }
}
