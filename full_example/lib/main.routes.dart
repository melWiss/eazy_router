// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: EazyRouteRegistrar
// **************************************************************************

import 'package:eazy_router/eazy_router.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:full_example/src/home.dart';

void registerRoutes() {
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'second': (params) => SecondScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'third': (params) => ThirdScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'home': (params) => HomeScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.setInitialRoute(HomeScaffoldRoute());
}
