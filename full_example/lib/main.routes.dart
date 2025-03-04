// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: EazyRouteRegistrar
// **************************************************************************

import 'package:eazy_router/eazy_router.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/bottom_sheet.dart';
import 'package:full_example/src/home_body.dart';
import 'package:full_example/src/processing_dialog.dart';
import 'package:full_example/src/third.dart';
import 'package:full_example/src/admin_page.dart';
import 'package:full_example/src/anonymous_bottom_sheet.dart';
import 'package:full_example/src/not_found_page.dart';
import 'package:full_example/src/home.dart';

void registerRoutes() {
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'second': (params) => SecondScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'bottom-sheet-example': (params) =>
          BottomSheetExampleRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'home-body': (params) => HomeBodyRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'processing': (params) => ProcessingDialogRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'third': (params) => ThirdScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'admin': (params) => AdminPageRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'anonymous-bottom-sheet': (params) =>
          AnonymousBottomSheetRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'not-found': (params) => NotFoundPageRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.setNotFoundRoute(NotFoundPageRoute());
  EazyRouterConfiguration.instance.router.registerRoutes(
    {
      'home': (params) => HomeScaffoldRoute.fromQueryParam(params),
    },
  );
  EazyRouterConfiguration.instance.router.setInitialRoute(HomeScaffoldRoute());
}
