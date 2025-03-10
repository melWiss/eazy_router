import 'package:eazy_router/src/eazy_route_information_parser.dart';
import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_back_button_dispatcher.dart';
import 'package:eazy_router/src/eazy_router_delegate.dart';
import 'package:flutter/material.dart';

class EazyRouterConfiguration extends RouterConfig<EazyRouteState>
    with WidgetsBindingObserver {
  EazyRouterConfiguration._()
      : super(
          backButtonDispatcher: EazyRouterBackButtonDispatcher(),
          routerDelegate: EazyRouterDelegate(),
          routeInformationParser: EazyRouteInformationParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: RouteInformation(
              uri: Uri.parse(
                WidgetsBinding.instance.platformDispatcher.defaultRouteName,
              ),
            ),
          ),
        );
  static EazyRouterConfiguration? _instance;
  static EazyRouterConfiguration instance =
      _instance ??= EazyRouterConfiguration._();

  EazyRouterDelegate get delegate => routerDelegate as EazyRouterDelegate;
  IEazyRouter get router => delegate.rootRouter;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void setOnDoubleBackButtonCloseMessage(SnackBar closingSnackbar) {
    (backButtonDispatcher as EazyRouterBackButtonDispatcher)
        .setOnDoubleBackButtonCloseMessage(closingSnackbar);
  }
}
