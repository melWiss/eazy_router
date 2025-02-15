// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class HomeScaffoldRoute extends EazyRoute {
  final String? title;

  HomeScaffoldRoute({
    this.title,
  });

  factory HomeScaffoldRoute.fromQueryParam(Map<String, String>? params) {
    return HomeScaffoldRoute(
// key=title,	value=String?
        );
  }

  @override
  Page get page => AdaptivePage(
        key: const ValueKey('home'),
        name: 'home',
        arguments: queryParameters,
        canPop: true,
        child: HomeScaffold(
          title: title,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (title != null) 'title': title!.toString(),
      };
}
