// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class WelcomePageRoute extends EazyRoute {
  final int? index;

  WelcomePageRoute({
    this.index,
  });

  factory WelcomePageRoute.fromQueryParam(Map<String, String>? params) {
    return WelcomePageRoute(
      index: params?['index'] == null ? null : int.tryParse(params!['index']!),
    );
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('welcome~$hashCode'),
        name: 'welcome',
        arguments: queryParameters,
        canPop: true,
        child: WelcomePage(
          index: index,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (index != null) 'index': index!.toString(),
      };
  @override
  String get parent => 'home';
}
