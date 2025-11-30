import 'package:flutter/material.dart';

class BottomSheetPage extends Page {
  const BottomSheetPage({
    super.key,
    super.name,
    super.arguments,
    super.canPop,
    required this.child,
    this.showDragHandle = false,
    this.isScrollControlled = false,
  });
  final Widget child;
  final bool showDragHandle;
  final bool isScrollControlled;
  @override
  Route createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      builder: (_) => child,
      isScrollControlled: isScrollControlled,
      settings: this,
      showDragHandle: showDragHandle,
    );
  }
}
