// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_page.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class AdminPageRoute extends EazyRoute {
  AdminPageRoute();

  factory AdminPageRoute.fromQueryParam(Map<String, String>? params) {
    return AdminPageRoute();
  }

  @override
  Page get page => AdaptivePage(
        key: const ValueKey('admin-page'),
        name: 'admin-page',
        arguments: queryParameters,
        canPop: true,
        child: AdminPage(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  List<EazyRouteMiddleware> get middlewares => [
        AdminMiddleware(),
      ];
}
