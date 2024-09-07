import 'package:flutter/material.dart';
import 'package:full_example/src/home.dart';
import 'package:full_example/src/second.dart';
import 'package:my_router/my_router.dart';
import 'package:my_router_annotation/my_router_annotation.dart';

part 'third.g.dart';

@GenerateRoute('third')
class ThirdScaffold extends StatelessWidget {
  const ThirdScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.removePageByName(SecondScaffoldRoute().page.name!,
                    notifyRootWidget: true);
              },
              child: const Text('remove second from stack'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('pop'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.popUntilTrue(
                  (page) => page.name == HomeScaffoldRoute().page.name,
                );
              },
              child: const Text('pop until home'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.pop(times: 2);
              },
              child: const Text('pop two times'),
            ),
          ],
        ),
      ),
    );
  }
}
