import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home.dart';
import 'package:full_example/src/third.dart';
part 'admin_page.g.dart';

@GenerateRoute(pathName: 'admin', guards: [AdminGuard()])
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
    );
  }
}

class AdminGuard extends EazyRouteGuard {
  static int decider = 6;
  const AdminGuard();
  @override
  bool onNavigation(EazyRouterResolver resolver) {
    if (decider++ % 5 == 0) {
      return true;
    } else if (decider % 5 == 1) {
      resolver.redirect([HomeScaffoldRoute()]);
    } else if (decider % 5 == 2) {
      resolver.goHome();
    } else if (decider % 5 == 3) {
      resolver.goNotFound();
    } else if (decider % 5 == 4) {
      resolver.push(ThirdScaffoldRoute());
    }
    return false;
  }
}
