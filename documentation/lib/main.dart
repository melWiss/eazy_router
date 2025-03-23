import 'package:documentation/src/search/search.dart';
import 'package:documentation/src/utils/colors.dart';
import 'package:documentation/src/utils/toasts.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:documentation/main.routes.dart';
import 'package:flutter/services.dart';

@RegisterRoutes()
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerRoutes();
  EazyRouterConfiguration.instance.setOnDoubleBackButtonCloseMessage(
    Toast(
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
    var shortcuts = <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyK, control: true):
          VoidCallbackIntent(
        () {
          EazyRouterConfiguration.instance.router.push(
            SearchDialogRoute(),
          );
        },
      ),
    };
    return MaterialApp.router(
      title: 'EazyRouter documentation',
      scaffoldMessengerKey:
          EazyRouterConfiguration.instance.scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: cardColor,
          brightness: Brightness.dark,
          surface: cardColor,
        ),
        useMaterial3: true,
      ),
      routerConfig: EazyRouterConfiguration.instance,
      shortcuts: shortcuts,
    );
  }
}
