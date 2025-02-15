import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.title ?? 'scaffold'}'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: Center(
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
                secondPagePoped = await context.router
                    ?.push<DateTime?>(SecondScaffoldRoute());
                setState(() {});
              },
              child: const Text('Go second'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.router?.pushRoutes([
                  SecondScaffoldRoute(),
                  ThirdScaffoldRoute(),
                ]);
              },
              child: const Text('Push second and third'),
            ),
          ],
        ),
      ),
    );
  }
}
