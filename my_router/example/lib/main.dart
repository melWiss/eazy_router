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
      routerConfig: MyRouteConfig(
        navigatorHandler: MyNavigatorHandler(
          initialPage: homePage,
          pages: pages,
        ),
      ),
    );
  }
}

// TODO: @generateRoute('home-scaffold')
class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    this.title,
    super.key,
  });
  // TODO: @queryParam
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${title ?? 'scaffold'}'),
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

class HomeRoute extends MyPageRoute {
  final String? title;

  HomeRoute({this.title});

  factory HomeRoute.fromQueryParam(Map<String, String>? params) {
    return HomeRoute(title: params?['title']);
  }

  @override
  Page get page => MaterialPage(
        key: const ValueKey('home'),
        name: 'home',
        arguments: queryParameters,
        child: HomeScaffold(
          title: title,
        ),
      );

  @override
  Map<String, String> get queryParameters => {
        if (title != null) 'title': title!,
      };
}

class SecondRoute extends MyPageRoute {
  @override
  Page get page => secondPage;

  @override
  Map<String, String> get queryParameters => const {};
}

class ThirdRoute extends MyPageRoute {
  @override
  Page get page => thirdPage;

  @override
  Map<String, String> get queryParameters => const {};
}

Map<String, MyPageRoute Function(Map<String, String>? params)> pages = {
  homePage.name!: (params) => HomeRoute.fromQueryParam(params),
  secondPage.name!: (params) => SecondRoute(),
  thirdPage.name!: (params) => ThirdRoute(),
};
