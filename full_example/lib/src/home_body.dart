import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/admin_page.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';

part 'home_body.g.dart';

@GenerateRoute(isAnonymous: true)
class HomeBody extends StatefulWidget {
  const HomeBody({
    this.router,
    super.key,
  });
  final IEazyRouter? router;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DateTime? secondPagePoped;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (secondPagePoped != null)
            Text(
                "Second page was poped on: ${secondPagePoped!.toIso8601String()}"),
          const Divider(),
          ElevatedButton(
            onPressed: () async {
              // use context to push
              secondPagePoped =
                  await widget.router?.push<DateTime?>(SecondScaffoldRoute());
              setState(() {});
            },
            child: const Text('Go second'),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              // use context to push
              widget.router?.pushRoutes([
                SecondScaffoldRoute(),
                ThirdScaffoldRoute(),
              ]);
            },
            child: const Text('Push second and third'),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              // use context to push
              widget.router?.pushRoutes([
                SecondScaffoldRoute(),
                ThirdScaffoldRoute(),
                AdminPageRoute(),
              ]);
            },
            child: const Text('Push second, third and admin'),
          ),
        ],
      ),
    );
  }
}
