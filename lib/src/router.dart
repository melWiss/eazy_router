import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:my_router/my_router.dart';

class MyRouteState {
  final String path;
  final Map<String, String>? params;
  MyRouteState({
    required this.path,
    this.params,
  });

  MyRouteState copyWith({
    String? path,
    Map<String, String>? params,
    String? pathId,
  }) {
    return MyRouteState(
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

  factory MyRouteState.fromMap(Map<String, dynamic> map) {
    return MyRouteState(
      path: map['path'] ?? '',
      params: Map<String, String>.from(map['params']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRouteState.fromJson(String source) =>
      MyRouteState.fromMap(json.decode(source));

  @override
  String toString() => 'MyRouteState(path: $path, params: $params)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyRouteState &&
        other.path == path &&
        mapEquals(other.params, params);
  }

  @override
  int get hashCode => path.hashCode ^ params.hashCode;

  factory MyRouteState.fromUri(Uri uri) {
    return MyRouteState(
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

class MyRouteInformationParser extends RouteInformationParser<MyRouteState> {
  @override
  Future<MyRouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    return MyRouteState.fromUri(routeInformation.uri);
  }

  @override
  RouteInformation? restoreRouteInformation(MyRouteState configuration) {
    return RouteInformation(
      uri: configuration.toUri(),
      state: configuration,
    );
  }
}

class MyRouterDelegate extends RouterDelegate<MyRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouteState> {
  final IMyNavigatorHandler navigatorHandler;
  MyRouterDelegate(this.navigatorHandler) {
    navigatorHandler.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) => MyNavigator(
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
  Future<void> setNewRoutePath(MyRouteState configuration) async {
    navigatorHandler.goTo(configuration.toUri());
    notifyListeners();
  }

  @override
  MyRouteState? get currentConfiguration =>
      MyRouteState.fromUri(navigatorHandler.currentUri);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}

class MyRouteConfig extends RouterConfig<MyRouteState>
    with WidgetsBindingObserver {
  MyRouteConfig({
    required IMyNavigatorHandler navigatorHandler,
  }) : super(
          routerDelegate: MyRouterDelegate(navigatorHandler),
          routeInformationParser: MyRouteInformationParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
              initialRouteInformation: RouteInformation(
            uri: Uri.parse(
                WidgetsBinding.instance.platformDispatcher.defaultRouteName),
          )),
        );
}
