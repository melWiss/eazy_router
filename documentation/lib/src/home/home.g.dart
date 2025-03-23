// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class HomePageRoute extends EazyRoute {
  HomePageRoute();

  factory HomePageRoute.fromQueryParam(Map<String, String>? params) {
    return HomePageRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('home~$hashCode'),
        name: 'home',
        arguments: queryParameters,
        canPop: true,
        child: HomePage(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isInitial => true;
}
