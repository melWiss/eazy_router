import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/admin_page.dart';
import 'package:full_example/src/anonymous_bottom_sheet.dart';
import 'package:full_example/src/bottom_sheet.dart';
import 'package:full_example/src/processing_dialog.dart';
import 'package:full_example/src/third.dart';

part 'second.g.dart';

@GenerateRoute(pathName: 'second', parent: 'nested')
class SecondScaffold extends StatefulWidget {
  const SecondScaffold({super.key});

  @override
  State<SecondScaffold> createState() => _SecondScaffoldState();
}

class _SecondScaffoldState extends State<SecondScaffold> {
  int selected = 0;
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
              onPressed: () async {
                var result =
                    await context.router?.push<int?>(BottomSheetExampleRoute());
                setState(() {
                  selected = result ?? 0;
                });
              },
              child: Text('open bottom sheet $selected'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                var result = await context.router
                    ?.push<int?>(AnonymousBottomSheetRoute());
                setState(() {
                  selected = result ?? 0;
                });
              },
              child: Text('open anonymous bottom sheet $selected'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.showSnackBar(
                  SampleToast(
                    title: 'Hello world',
                    toastDuration: const Duration(seconds: 10),
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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.router?.pop();
                });
              },
              child: const Text('open processing dialog'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                context.router?.push(AdminPageRoute());
              },
              child: const Text('open admin page'),
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
