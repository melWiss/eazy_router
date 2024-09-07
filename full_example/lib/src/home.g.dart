// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class HomeScaffoldRoute extends MyPageRoute {
  final String? title;

  HomeScaffoldRoute({
    this.title,
  });

  factory HomeScaffoldRoute.fromQueryParam(Map<String, String>? params) {
    return HomeScaffoldRoute(
      title: params?['title'],
    );
  }

  @override
  Page get page => MaterialPage(
        key: const ValueKey('home'),
        name: 'home',
        arguments: queryParameters,
        child: HomeScaffold(
          title: title,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (title != null) 'title': title!.toString(),
      };
}
