import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home_body/nested_home_body.dart';
import 'package:full_example/src/home_body/non_nested_home_body.dart';

part 'home.g.dart';

@GenerateRoute(pathName: 'home', isInitial: true)
class HomeScaffold extends StatefulWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  DateTime? secondPagePoped;
  int navigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return EazyRouterNavigator(
      routerKey: 'nested',
      onRouterCreation: (router) => router.setInitialRoute(
        NestedHomeBodyRoute(router: router),
      ),
      listener: (router, currentRoute) {
        print(currentRoute);
      },
      builder: (navigator, router) {
        return Scaffold(
          body: navigator,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationBarIndex,
            onDestinationSelected: (value) {
              if (navigationBarIndex != value) {
                navigationBarIndex = value;
                if (navigationBarIndex == 0) {
                  router.replaceRoutes(
                    [
                      NestedHomeBodyRoute(
                        router: router,
                      ),
                    ],
                  );
                } else {
                  router.replaceRoutes(
                    [
                      NonNestedHomeBodyRoute(
                        router: router.parent!,
                      ),
                    ],
                  );
                }
              }
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'home'),
              NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
            ],
          ),
        );
      },
    );
  }
}
