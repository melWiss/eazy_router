import 'package:flutter/material.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:my_router/my_router.dart';
import 'package:my_router_annotation/my_router_annotation.dart';

part 'home.g.dart';

@GenerateRoute('home')
class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    this.title,
    super.key,
  });
  @QueryParam('title')
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${title ?? 'scaffold'}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.push(SecondScaffoldRoute().page);
              },
              child: const Text('Go second'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.pushPages([
                  SecondScaffoldRoute().page,
                  ThirdScaffoldRoute().page,
                ]);
              },
              child: const Text('Push second and third'),
            ),
          ],
        ),
      ),
    );
  }
}