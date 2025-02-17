import 'package:eazy_router/src/eazy_route_state.dart';
import 'package:flutter/material.dart';

class EazyRouteInformationParser extends RouteInformationParser<EazyRouteState> {
  @override
  Future<EazyRouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    return EazyRouteState.fromUri(routeInformation.uri);
  }

  @override
  RouteInformation? restoreRouteInformation(EazyRouteState configuration) {
    return RouteInformation(
      uri: configuration.toUri(),
      state: configuration,
    );
  }
}