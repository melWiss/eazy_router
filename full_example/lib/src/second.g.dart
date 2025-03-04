// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class SecondScaffoldRoute extends EazyRoute {
  SecondScaffoldRoute();

  factory SecondScaffoldRoute.fromQueryParam(Map<String, String>? params) {
    return SecondScaffoldRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('second~$hashCode'),
        name: 'second',
        arguments: queryParameters,
        canPop: true,
        child: SecondScaffold(),
      );

  @override
  Map<String, String> get queryParameters => {};
}
