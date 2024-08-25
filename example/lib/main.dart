import 'package:flutter/material.dart';
import 'package:my_router/my_router.dart';

void main() {
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
      // routerConfig: MyRouteConfig(
      //   navigatorHandler: MyNavigatorHandler(
      //     initialPage: homePage,
      //     pages: pages,
      //   ),
      // ),
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: MyRouterDelegate(
        MyNavigatorHandler(
          initialPage: homePage,
          pages: pages,
        ),
      ),
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.push(secondPage);
              },
              child: const Text('Go second'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.pushPages([
                  secondPage,
                  thirdPage,
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

class SecondScaffold extends StatelessWidget {
  const SecondScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('pop'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.push(thirdPage);
              },
              child: const Text('go to third'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScaffold extends StatelessWidget {
  const ThirdScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third scaffold'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.removePage(secondPage, notifyRootWidget: true);
              },
              child: const Text('remove second from stack'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('pop'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.popUntilTrue(
                  (page) => page.name == homePage.name,
                );
              },
              child: const Text('pop until home'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.pop(times: 2);
              },
              child: const Text('pop two times'),
            ),
          ],
        ),
      ),
    );
  }
}

Page homePage = const MaterialPage(
  key: ValueKey('home'),
  name: 'home',
  child: HomeScaffold(),
);
Page secondPage = const MaterialPage(
  key: ValueKey('second'),
  name: 'second',
  child: SecondScaffold(),
);
Page thirdPage = const MaterialPage(
  key: ValueKey('third'),
  name: 'third',
  child: ThirdScaffold(),
);

Map<String, Page> pages = {
  homePage.name!: homePage,
  secondPage.name!: secondPage,
  thirdPage.name!: thirdPage,
};
