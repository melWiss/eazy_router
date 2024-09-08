import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/main.routes.dart';
import 'package:eazy_router/eazy_router.dart';

@RegisterRoutes()
void main() {
  registerRoutes();
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
