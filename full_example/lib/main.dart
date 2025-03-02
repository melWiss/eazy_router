import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/main.routes.dart';
import 'package:full_example/src/second.dart';

@RegisterRoutes()
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerRoutes();
  EazyRouterConfiguration.instance.setOnDoubleBackButtonCloseMessage(
    SampleToast(
      title: 'Press back button again to close',
      toastDuration: const Duration(seconds: 3),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      scaffoldMessengerKey:
          EazyRouterConfiguration.instance.scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: EazyRouterConfiguration.instance,
    );
  }
}
