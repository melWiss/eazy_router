// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_body.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class HomeBodyRoute extends EazyRoute {
  final IEazyRouter? router;

  HomeBodyRoute({
    this.router,
  });

  factory HomeBodyRoute.fromQueryParam(Map<String, String>? params) {
    return HomeBodyRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: ValueKey('home-body~$hashCode'),
        name: 'home-body',
        arguments: queryParameters,
        canPop: false,
        child: HomeBody(
          router: router,
        ),
      );

  @override
  Map<String, String> get queryParameters => {};
}
