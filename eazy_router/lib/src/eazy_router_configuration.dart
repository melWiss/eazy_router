import 'package:eazy_router/src/eazy_route_information_parser.dart';
import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:eazy_router/src/eazy_router.dart';
import 'package:eazy_router/src/eazy_router_delegate.dart';
import 'package:flutter/material.dart';

class EazyRouterConfiguration extends RouterConfig<EazyRouteState>
    with WidgetsBindingObserver {
  EazyRouterConfiguration._()
      : super(
          backButtonDispatcher: RootBackButtonDispatcher(),
          routerDelegate: EazyRouterDelegate(EazyRouter()),
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
  IEazyRouter get router => delegate.router;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
