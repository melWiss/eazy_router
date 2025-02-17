import 'package:flutter/material.dart';

class DialogPage extends Page {
  const DialogPage({
    super.key,
    super.name,
    super.arguments,
    super.canPop,
    required this.child,
  });
  final Widget child;
  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      builder: (_) => child,
      settings: this,
    );
  }
}
