import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:eazy_router/eazy_router.dart';

class EazyRouteState {
  final String path;
  final Map<String, String>? params;
  EazyRouteState({
    required this.path,
    this.params,
  });

  EazyRouteState copyWith({
    String? path,
    Map<String, String>? params,
    String? pathId,
  }) {
    return EazyRouteState(
      path: path ?? this.path,
      params: params ?? this.params,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'params': params,
    };
  }

  factory EazyRouteState.fromMap(Map<String, dynamic> map) {
    return EazyRouteState(
      path: map['path'] ?? '',
      params: Map<String, String>.from(map['params']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EazyRouteState.fromJson(String source) =>
      EazyRouteState.fromMap(json.decode(source));

  @override
  String toString() => 'EazyRouteState(path: $path, params: $params)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EazyRouteState &&
        other.path == path &&
        mapEquals(other.params, params);
  }

  @override
  int get hashCode => path.hashCode ^ params.hashCode;

  factory EazyRouteState.fromUri(Uri uri) {
    return EazyRouteState(
      path: uri.path,
      params: uri.queryParameters,
    );
  }

  Uri toUri() {
    return Uri(
      path: path,
      queryParameters: params,
    );
  }
}

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

class EazyRouterDelegate extends RouterDelegate<EazyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EazyRouteState> {
  final IEazyRouterHandler navigatorHandler;
  EazyRouterDelegate(this.navigatorHandler) {
    navigatorHandler.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) => EazyRouterNavigator(
        navigatorHandler: navigatorHandler,
        key: navigatorKey,
      );

  @override
  Future<bool> popRoute() async {
    navigatorHandler.pop();
    notifyListeners();
    return true;
  }

  @override
  Future<void> setNewRoutePath(EazyRouteState configuration) async {
    navigatorHandler.goTo(configuration.toUri());
    notifyListeners();
  }

  @override
  EazyRouteState? get currentConfiguration =>
      EazyRouteState.fromUri(navigatorHandler.currentUri);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}

class EazyRouter extends RouterConfig<EazyRouteState>
    with WidgetsBindingObserver {
  EazyRouter() : super(
          routerDelegate: EazyRouterDelegate(EazyRouterHandler()),
          routeInformationParser: EazyRouteInformationParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
              initialRouteInformation: RouteInformation(
            uri: Uri.parse(
                WidgetsBinding.instance.platformDispatcher.defaultRouteName),
          )),
        );
}
