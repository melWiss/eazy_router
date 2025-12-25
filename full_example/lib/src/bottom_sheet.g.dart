// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_sheet.dart';

// **************************************************************************
// ModalBottomSheetGenerator
// **************************************************************************

class BottomSheetExampleRoute extends EazyRoute {
  BottomSheetExampleRoute();

  factory BottomSheetExampleRoute.fromQueryParam(Map<String, String>? params) {
    return BottomSheetExampleRoute();
  }

  @override
  Page get page => BottomSheetPage(
        key: ValueKey('bottom-sheet-example~$hashCode'),
        name: 'bottom-sheet-example',
        arguments: queryParameters,
        canPop: true,
        showDragHandle: true,
        isScrollControlled: false,
        child: BottomSheetExample(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isAnonymous => true;
}
