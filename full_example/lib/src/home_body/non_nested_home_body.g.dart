// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_nested_home_body.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class NonNestedHomeBodyRoute extends EazyRoute {
  final IEazyRouter? router;
  final String? title;

  NonNestedHomeBodyRoute({
    this.router,
    this.title,
  });

  factory NonNestedHomeBodyRoute.fromQueryParam(Map<String, String>? params) {
    return NonNestedHomeBodyRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('non-nested~$hashCode'),
        name: 'non-nested',
        arguments: queryParameters,
        canPop: true,
        child: NonNestedHomeBody(
          router: router,
          title: title,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (title != null) 'title': title!.toString(),
      };
  @override
  String get parent => 'nested';
}
