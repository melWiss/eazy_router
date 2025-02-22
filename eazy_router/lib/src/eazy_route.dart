import 'package:eazy_router/src/abstract_eazy_route.dart';
import 'package:eazy_router/src/other/eazy_route_middleware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class EazyRoute extends AbstractEazyRoute {
  Map<String, String> get queryParameters;
  Page get page;
  bool get isAnonymous => false;
  bool get isInitial => false;
  List<EazyRouteMiddleware> get middlewares => [];
}
