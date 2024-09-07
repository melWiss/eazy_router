// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: EazyRouteRegistrar
// **************************************************************************

import 'package:eazy_router/eazy_router.dart';
import 'package:full_example/src/third.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/home.dart';

void $_registerRoutes() {
// ./.dart_tool/build/generated/full_example/lib/src/third.route.g.part
  EazyRouterHandler().registerRoutes(
      {'third': (params) => ThirdScaffoldRoute.fromQueryParam(params)});
// ./.dart_tool/build/generated/full_example/lib/src/second.route.g.part
  EazyRouterHandler().registerRoutes(
      {'second': (params) => SecondScaffoldRoute.fromQueryParam(params)});
// ./.dart_tool/build/generated/full_example/lib/src/home.route.g.part
  EazyRouterHandler().registerRoutes(
      {'home': (params) => HomeScaffoldRoute.fromQueryParam(params)});
}
