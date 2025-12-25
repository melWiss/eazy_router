// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal_scrollable_bottom_sheet.dart';

// **************************************************************************
// ModalBottomSheetGenerator
// **************************************************************************

class ModalScrollableBottomSheetRoute extends EazyRoute {
  ModalScrollableBottomSheetRoute();

  factory ModalScrollableBottomSheetRoute.fromQueryParam(
      Map<String, String>? params) {
    return ModalScrollableBottomSheetRoute();
  }

  @override
  Page get page => BottomSheetPage(
        key: ValueKey('modal-scrollable-bottom-sheet~$hashCode'),
        name: 'modal-scrollable-bottom-sheet',
        arguments: queryParameters,
        canPop: true,
        showDragHandle: true,
        isScrollControlled: true,
        child: ModalScrollableBottomSheet(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isAnonymous => true;
}
