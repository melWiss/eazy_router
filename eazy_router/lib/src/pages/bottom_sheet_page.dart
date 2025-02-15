import 'package:flutter/material.dart';

class BottomSheetPage extends Page {
  const BottomSheetPage({
    super.key,
    super.name,
    super.arguments,
    super.canPop,
    required this.child,
  });
  final Widget child;
  @override
  Route createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      builder: (_) => child,
      isScrollControlled: false,
      settings: this,
    );
  }
}
