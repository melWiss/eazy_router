import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home_body.dart';

part 'home.g.dart';

@GenerateRoute(pathName: 'home', isInitial: true)
class HomeScaffold extends StatefulWidget {
  const HomeScaffold({
    this.title,
    super.key,
  });

  final String? title;

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  DateTime? secondPagePoped;
  int navigationBarIndex = 0;
  IEazyRouter router = EazyRouter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.title ?? 'scaffold'}'),
      ),
      bottomNavigationBar: ListenableBuilder(
          listenable: router,
          builder: (context, _) {
            return NavigationBar(
              selectedIndex: navigationBarIndex,
              onDestinationSelected: (value) {
                if (navigationBarIndex != value) {
                  navigationBarIndex = value;
                  if (navigationBarIndex == 0) {
                    router.replaceRoutes([HomeBodyRoute(router: router)]);
                  } else {
                    router
                        .replaceRoutes([HomeBodyRoute(router: router.parent!)]);
                  }
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'home'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'profile'),
              ],
            );
          }),
      body: EazyRouterNavigator(
        router: router,
        initialRoute: HomeBodyRoute(router: router),
      ),
    );
  }
}
