# EazyRouter Documentation

EazyRouter is a flexible and easy-to-use navigation package for Flutter that leverages code generation to simplify route management. This documentation will guide you through the key features and usage of EazyRouter.

## Table of Contents

1. [Installation](#installation)
2. [Getting Started](#getting-started)
3. [Annotations](#annotations)
   - [@RegisterRoutes](#registerroutes)
   - [@GenerateRoute](#generateroute)
4. [Using EazyRouter](#using-eazyrouter)
   - [Basic Routing](#basic-routing)
   - [Navigating Between Pages](#navigating-between-pages)
   - [Pushing a Stack of Pages](#pushing-a-stack-of-pages)
5. [Example](#example)

## Installation

To install EazyRouter, add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  eazy_router: ^x.x.x
  eazy_router_annotation: ^x.x.x

dev_dependencies:
  build_runner: ^x.x.x
  eazy_router_generator: ^x.x.x
```

Replace `x.x.x` with the latest versions available on [pub.dev](https://pub.dev/).

## Getting Started

EazyRouter uses annotations and code generation to automatically create routes for your application. Follow these steps to get started:

1. Annotate your main function with `@RegisterRoutes`.
2. Annotate each page with `@GenerateRoute` to generate the route definitions.
3. Run the build runner to generate the necessary files.

## Annotations

### @RegisterRoutes

This annotation is used to mark the entry point of your app where routes are registered. Typically, you will place this annotation on your `main` function.

```dart
@RegisterRoutes()
void main() {
  registerRoutes();
  runApp(const MyApp());
}
```

### @GenerateRoute

Use this annotation on your page classes to generate the corresponding routes. You must specify the `pathName` for the route, and you can optionally designate the route as the initial route.

```dart
@GenerateRoute(pathName: 'home', isInitial: true)
class HomeScaffold extends StatelessWidget {
  // Widget implementation
}
```

## Using EazyRouter

### Basic Routing

To use the generated routes in your app, set up `EazyRouter` as the router configuration in your `MaterialApp`:

```dart
MaterialApp.router(
  routerConfig: EazyRouter(),
)
```

### Navigating Between Pages

You can navigate between pages using the generated route classes:

```dart
context.push(SecondScaffoldRoute());
```

### Pushing a Stack of Pages

EazyRouter allows you to push a stack of pages in one method call. This can be useful when you want to navigate through multiple screens in one go.

```dart
context.pushRoutes([
  SecondScaffoldRoute(),
  ThirdScaffoldRoute(),
]);
```

## Example

Here is a complete example using EazyRouter:

```dart
// main.dart
import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:full_example/main.routes.dart';
import 'package:eazy_router/eazy_router.dart';

@RegisterRoutes()
void main() {
  registerRoutes();
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
      routerConfig: EazyRouter(),
    );
  }
}

// src/home.dart
import 'package:flutter/material.dart';
import 'package:full_example/src/second.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';

part 'home.g.dart';

@GenerateRoute(pathName: 'home', isInitial: true)
class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    this.title,
    super.key,
  });
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
                context.push(SecondScaffoldRoute());
              },
              child: const Text('Go second'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                // use context to push
                context.pushRoutes([
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

// src/second.dart
import 'package:flutter/material.dart';
import 'package:full_example/src/third.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';

part 'second.g.dart';

@GenerateRoute(pathName: 'second')
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
                context.push(ThirdScaffoldRoute());
              },
              child: const Text('go to third'),
            ),
          ],
        ),
      ),
    );
  }
}

// src/third.dart
import 'package:flutter/material.dart';
import 'package:full_example/src/home.dart';
import 'package:full_example/src/second.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';

part 'third.g.dart';

@GenerateRoute(pathName: 'third')
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
                context.removeRouteByName(SecondScaffoldRoute().page.name!,
                    notifyRootWidget: true);
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
                  (route) => route.page.name == HomeScaffoldRoute().page.name,
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
```

This example demonstrates how to define routes and navigate between pages using EazyRouter. The code generation creates the necessary route classes and ensures type-safe navigation throughout your app.
