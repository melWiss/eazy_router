import 'package:eazy_router/eazy_router.dart';
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
    this.minChildSize = 0.25,
    this.initialChildSize = 0.5,
    this.maxChildSize = 1.0,
  });
  final Widget child;
  final bool showDragHandle;
  final bool isScrollControlled;
  final double minChildSize;
  final double maxChildSize;
  final double initialChildSize;
  @override
  Route createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      builder: (_) {
        if (isScrollControlled) {
          return DraggableScrollableSheet(
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            initialChildSize: initialChildSize,
            expand: false,
            builder: (context, scrollController) {
              return ChangeNotifierProvider<ScrollController>.value(
                value: scrollController,
                child: child,
              );
            },
          );
        }
        return child;
      },
      isScrollControlled: isScrollControlled,
      settings: this,
      showDragHandle: showDragHandle,
    );
  }
}
