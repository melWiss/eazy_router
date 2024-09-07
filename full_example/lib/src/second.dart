import 'package:flutter/material.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';

part 'second.g.dart';

@GenerateRoute('second')
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
                context.pop();
              },
              child: const Text('pop'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.push(ThirdScaffoldRoute().page);
              },
              child: const Text('go to third'),
            ),
          ],
        ),
      ),
    );
  }
}