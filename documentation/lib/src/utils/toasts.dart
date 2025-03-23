import 'package:flutter/material.dart';

class Toast extends SnackBar {
  Toast({
    super.key,
    required String title,
    ToastType toastType = ToastType.info,
    bool showClose = false,
    Duration toastDuration = Durations.medium2,
  }) : super(
          content: Text(title),
          backgroundColor: toastType.color,
          showCloseIcon: showClose,
          duration: toastDuration,
          behavior: SnackBarBehavior.floating,
        );
}

enum ToastType {
  info,
  danger,
  warning,
  success;

  Color get color => switch (this) {
        danger => Colors.red,
        warning => Colors.orange,
        success => Colors.green,
        _ => Colors.black,
      };
}
