// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_dialog.dart';

// **************************************************************************
// EazyRouteGenerator
// **************************************************************************

class ProcessingDialogRoute extends EazyRoute {
  ProcessingDialogRoute();

  factory ProcessingDialogRoute.fromQueryParam(Map<String, String>? params) {
    return ProcessingDialogRoute();
  }

  @override
  Page get page => DialogPage(
        key: const ValueKey('processing'),
        name: 'processing',
        arguments: queryParameters,
        canPop: false,
        child: ProcessingDialog(),
      );

  @override
  Map<String, String> get queryParameters => {};
  @override
  bool get isAnonymous => true;
}
