// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class WelcomePageRoute extends EazyRoute {
  WelcomePageRoute();

  factory WelcomePageRoute.fromQueryParam(Map<String, String>? params) {
    return WelcomePageRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('welcome~$hashCode'),
        name: 'welcome',
        arguments: queryParameters,
        canPop: true,
        child: WelcomePage(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  String get parent => 'home';
}
