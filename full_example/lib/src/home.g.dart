// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class HomeScaffoldRoute extends EazyRoute {
  HomeScaffoldRoute();

  factory HomeScaffoldRoute.fromQueryParam(Map<String, String>? params) {
    return HomeScaffoldRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('home~$hashCode'),
        name: 'home',
        arguments: queryParameters,
        canPop: true,
        child: HomeScaffold(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isInitial => true;
}
