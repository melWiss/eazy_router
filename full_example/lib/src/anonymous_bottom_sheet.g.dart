// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anonymous_bottom_sheet.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class AnonymousBottomSheetRoute extends EazyRoute {
  AnonymousBottomSheetRoute();

  factory AnonymousBottomSheetRoute.fromQueryParam(
      Map<String, String>? params) {
    return AnonymousBottomSheetRoute();
  }

  @override
  Page get page => BottomSheetPage(
        key: ValueKey('anonymous-bottom-sheet~$hashCode'),
        name: 'anonymous-bottom-sheet',
        arguments: queryParameters,
        canPop: true,
        child: AnonymousBottomSheet(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isAnonymous => true;
}
