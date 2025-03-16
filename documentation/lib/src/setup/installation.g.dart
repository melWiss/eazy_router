// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installation.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class InstallationPageRoute extends EazyRoute {
  InstallationPageRoute();

  factory InstallationPageRoute.fromQueryParam(Map<String, String>? params) {
    return InstallationPageRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('installation~$hashCode'),
        name: 'installation',
        arguments: queryParameters,
        canPop: true,
        child: InstallationPage(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  String get parent => 'home';
}
