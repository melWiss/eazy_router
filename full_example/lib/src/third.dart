import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home.dart';
import 'package:full_example/src/second.dart';
import 'package:eazy_router/eazy_router.dart';

part 'third.g.dart';

@GenerateRoute(pathName: 'third')
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
                context.removeRouteByName(SecondScaffoldRoute().page.name!,
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
                  (route) => route.page.name == HomeScaffoldRoute().page.name,
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
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.replaceRoutes(context.routeSack.reversed.toList());
              },
              child: const Text('replace routes => /third/second/home'),
            ),
          ],
        ),
      ),
    );
  }
}
