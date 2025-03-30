import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/src/pages/anonymous_page.dart';
import 'package:flutter/material.dart';

class AnonymousEazyRoute<T> extends EazyRoute {
  final Route<T> route;

  AnonymousEazyRoute({required this.route});
  @override
  Page get page => AnonymousPage(route: route);

  @override
  bool get isAnonymous => page.name == null;

  @override
  Map<String, String> get queryParameters {
    if (page.arguments is Map<String, String>) {
      return page.arguments as Map<String, String>;
    }
    return {};
  }
}
