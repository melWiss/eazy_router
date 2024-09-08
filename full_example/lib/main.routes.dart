// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: EazyRouteRegistrar
// **************************************************************************

import 'package:eazy_router/eazy_router.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:full_example/src/home.dart';

void registerRoutes() {
  EazyRouterHandler().registerRoutes(
      {'second': (params) => SecondScaffoldRoute.fromQueryParam(params)});
  EazyRouterHandler().registerRoutes(
      {'third': (params) => ThirdScaffoldRoute.fromQueryParam(params)});
  EazyRouterHandler().setInitialRoute(HomeScaffoldRoute());
  EazyRouterHandler().registerRoutes(
      {'home': (params) => HomeScaffoldRoute.fromQueryParam(params)});
}
