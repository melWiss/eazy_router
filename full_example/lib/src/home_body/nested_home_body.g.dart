// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_home_body.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class NestedHomeBodyRoute extends EazyRoute {
  final IEazyRouter? router;
  final String? title;

  NestedHomeBodyRoute({
    this.router,
    this.title,
  });

  factory NestedHomeBodyRoute.fromQueryParam(Map<String, String>? params) {
    return NestedHomeBodyRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('nested~$hashCode'),
        name: 'nested',
        arguments: queryParameters,
        canPop: true,
        child: NestedHomeBody(
          router: router,
          title: title,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (title != null) 'title': title!.toString(),
      };
}
