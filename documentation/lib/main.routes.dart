// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: EazyRouteRegistrar
// **************************************************************************

import 'package:eazy_router/eazy_router.dart';
import 'package:documentation/src/home/home.dart';
import 'package:documentation/src/welcome/welcome.dart';
import 'package:documentation/src/search/search.dart';
import 'package:documentation/src/setup/installation.dart';

void registerRoutes() {
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'home': (params) => HomePageRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.setInitialRoute(HomePageRoute());
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'welcome': (params) => WelcomePageRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'search-dialog': (params) => SearchDialogRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'installation': (params) => InstallationPageRoute.fromQueryParam(params),
    },
  );
}
