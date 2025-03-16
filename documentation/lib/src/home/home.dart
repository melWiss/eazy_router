import 'package:documentation/src/home/desktop_home_body.dart';
import 'package:documentation/src/home/home_mixin.dart';
import 'package:documentation/src/utils/constants.dart';
import 'package:documentation/src/utils/fade_in_page_transition.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:documentation/src/welcome/welcome.dart';

part 'home.g.dart';

@GenerateRoute(isInitial: true, pathName: 'home')
class HomePage extends StatelessWidget with HomePageHelpersMixin {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return EazyRouterNavigator(
      routerKey: homeNavigatorKey,
      onRouterCreation: (router) => router.setInitialRoute(WelcomePageRoute()),
      builder: (navigator, router) => LayoutBuilder(
        builder: (context, constraints) {
          var child = Theme(
            data: Theme.of(context).copyWith(
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.linux: FadeInPageTransitionsBuilder(),
                  TargetPlatform.macOS: FadeInPageTransitionsBuilder(),
                  TargetPlatform.iOS: FadeInPageTransitionsBuilder(),
                  TargetPlatform.android: FadeInPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeInPageTransitionsBuilder(),
                  TargetPlatform.fuchsia: FadeInPageTransitionsBuilder(),
                },
              ),
            ),
            child: navigator,
          );
          if (constraints.maxWidth >= constraints.maxHeight) {
            return DesktopHomeBody(
              constraints: constraints,
              child: child,
            );
          }
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              destinations: destinations,
              selectedIndex: getSelectedIndex(router.currentRoute!.page.name!),
              onDestinationSelected: (value) {
                router.replaceRoutes([destinationsIndexPath[value]]);
              },
            ),
          );
        },
      ),
    );
  }
}
