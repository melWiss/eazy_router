// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class ThirdScaffoldRoute extends EazyRoute {
  ThirdScaffoldRoute();

  factory ThirdScaffoldRoute.fromQueryParam(Map<String, String>? params) {
    return ThirdScaffoldRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('third~$hashCode'),
        name: 'third',
        arguments: queryParameters,
        canPop: true,
        child: ThirdScaffold(),
      );

  @override
  Map<String, String> get queryParameters => {};
}
