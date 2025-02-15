import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptivePage<T> extends Page<T> {
  const AdaptivePage({
    super.key,
    super.name,
    super.arguments,
    super.canPop,
    required this.child,
  });
  final Widget child;
  @override
  Route<T> createRoute(BuildContext context) {
    if (kIsWeb) {
      return MaterialPageRoute<T>(
        builder: (_) => child,
        settings: this,
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoPageRoute<T>(
        builder: (_) => child,
        settings: this,
      );
    }
    return MaterialPageRoute<T>(
      builder: (_) => child,
      settings: this,
    );
  }
}
