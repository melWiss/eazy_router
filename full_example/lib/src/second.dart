import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/bottom_sheet.dart';
import 'package:full_example/src/processing_dialog.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';

part 'second.g.dart';

@GenerateRoute(pathName: 'second')
class SecondScaffold extends StatelessWidget {
  const SecondScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.router?.pop(data: DateTime.now());
              },
              child: const Text('pop'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.router?.push(ThirdScaffoldRoute());
              },
              child: const Text('go to third'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.router?.push(BottomSheetExampleRoute());
              },
              child: const Text('open bottom sheet'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.showSnackBar(
                  SampleToast(
                    title: 'Hello world',
                    toastDuration: const Duration(seconds: 3),
                  ),
                );
              },
              child: const Text('show a snackbar'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                context.router?.push(ProcessingDialogRoute());
                await Future.delayed(const Duration(seconds: 5));
                context.router?.pop();
              },
              child: const Text('open processing dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleToast extends SnackBar {
  SampleToast({
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
