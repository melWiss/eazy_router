import 'package:flutter/material.dart';
import 'package:full_example/routes.dart';
import 'package:full_example/src/home.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';

void main() {
  registerRoutes();
  EazyRouterHandler().setInitialRoute(HomeScaffoldRoute());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: EazyRouter(),
    );
  }
}
