import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home.dart';

part 'not_found_page.g.dart';

@GenerateRoute(isNotFoundRoute: true, pathName: 'not-found')
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not found"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router?.replaceRoutes([HomeScaffoldRoute()]);
          },
          child: const Text("return to home"),
        ),
      ),
    );
  }
}
