// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_found_page.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class NotFoundPageRoute extends EazyRoute {
  NotFoundPageRoute();

  factory NotFoundPageRoute.fromQueryParam(Map<String, String>? params) {
    return NotFoundPageRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: const ValueKey('not-found'),
        name: 'not-found',
        arguments: queryParameters,
        canPop: true,
        child: NotFoundPage(),
      );

  @override
  Map<String, String> get queryParameters => {};
}
