// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class SearchDialogRoute extends EazyRoute {
  SearchDialogRoute();

  factory SearchDialogRoute.fromQueryParam(Map<String, String>? params) {
    return SearchDialogRoute();
  }

  @override
  Page get page => DialogPage(
        key: ValueKey('search-dialog~$hashCode'),
        name: 'search-dialog',
        arguments: queryParameters,
        canPop: true,
        child: SearchDialog(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isAnonymous => true;
}
