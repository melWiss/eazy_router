import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

abstract class IMyNavigatorHandler with ChangeNotifier {
  final Map<String, Page> pages;

  IMyNavigatorHandler({required this.pages});
  void push(Page page);
  void pushPages(List<Page> pages);
  void pop({int times = 1});
  void removePage(Page page, {bool notifyRootWidget = false});
  void removePageByName(String name, {bool notifyRootWidget = false});
  void popUntilTrue(bool Function(Page page) predicate);
  void goTo(Uri uri);
  bool hasPage(String name);
  Stream<List<Page>> get stream;
  Uri get currentUri;
}

class MyNavigatorHandler extends IMyNavigatorHandler {
  List<Page> _state = [];
  final BehaviorSubject<List<Page>> _controller = BehaviorSubject();

  MyNavigatorHandler({
    required Page initialPage,
    required super.pages,
  }) {
    _state = [initialPage];
    _controller.add(_state);
    _controller.listen(
      (value) => notifyListeners(),
    );
  }
  @override
  void push(Page page) {
    _state = List.from([..._state, page]);
    _controller.add(_state);
  }

  @override
  void pushPages(List<Page> pages) {
    _state = List.from([..._state, ...pages]);
    _controller.add(_state);
  }

  @override
  void pop({int times = 1}) {
    _state.removeRange(_state.length - times, _state.length);
    _state = List.from(_state);
    _controller.add(_state);
  }

  @override
  void popUntilTrue(bool Function(Page page) predicate) {
    while (!predicate(_state.last)) {
      _state.removeLast();
    }
    _state = List.from(_state);
    _controller.add(_state);
  }

  @override
  Stream<List<Page>> get stream => _controller.stream;

  @override
  void removePage(Page page, {bool notifyRootWidget = false}) {
    if (_state.contains(page)) {
      _state.remove(page);
      if (notifyRootWidget) {
        _state = List.from(_state);
        _controller.add(_state);
      }
    }
  }

  @override
  void removePageByName(String name, {bool notifyRootWidget = false}) {
    var pageToRemove = _state.firstWhere((element) => element.name == name);
    _state.remove(pageToRemove);
    if (notifyRootWidget) {
      _state = List.from(_state);
      _controller.add(_state);
    }
  }

  @override
  bool hasPage(String name) => _state.any((element) => element.name == name);

  @override
  void goTo(Uri uri) {
    _state = List.empty(growable: true);
    for (var path in uri.pathSegments) {
      if (pages[path] != null) {
        _state.add(pages[path]!);
      }
    }
    if (_state.isEmpty) {
      _state.add(pages.values.first);
    }
    _controller.add(_state);
  }

  @override
  Uri get currentUri {
    String completePath = '/';
    for (var page in _state) {
      completePath += '${page.name}/';
    }
    return Uri.parse(completePath);
  }
}

class MyNavigator extends StatelessWidget {
  const MyNavigator({
    required IMyNavigatorHandler navigatorHandler,
    this.navigatorKey,
    super.key,
  }) : _navigatorHandler = navigatorHandler;

  final IMyNavigatorHandler _navigatorHandler;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    MyNavigatorContext._navigatorHandler = _navigatorHandler;
    return ChangeNotifierProvider<IMyNavigatorHandler>.value(
      value: _navigatorHandler,
      builder: (_, __) => StreamBuilder<List<Page>>(
        stream: _navigatorHandler.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Page<dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: snapshot.data!,
              key: navigatorKey,
              onGenerateRoute: (settings) {
                if (settings.name != null &&
                    _navigatorHandler.hasPage(settings.name!)) {
                  return _navigatorHandler.pages[settings.name]!
                      .createRoute(context);
                }
                return _navigatorHandler.pages.values.first
                    .createRoute(context);
              },
              onDidRemovePage: _navigatorHandler.removePage,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

extension MyNavigatorContext on BuildContext {
  static late IMyNavigatorHandler _navigatorHandler;

  void push(Page page) => _navigatorHandler.push(page);
  void pushPages(List<Page> pages) => _navigatorHandler.pushPages(pages);
  void pop({int times = 1}) => _navigatorHandler.pop(times: times);
  void removePage(Page page, {bool notifyRootWidget = false}) =>
      _navigatorHandler.removePage(page, notifyRootWidget: notifyRootWidget);
  void removePageByName(String name, {bool notifyRootWidget = false}) =>
      _navigatorHandler.removePageByName(
        name,
        notifyRootWidget: notifyRootWidget,
      );
  void popUntilTrue(bool Function(Page page) predicate) =>
      _navigatorHandler.popUntilTrue(predicate);
  bool hasPage(String name) => _navigatorHandler.hasPage(name);
  Stream<List<Page>> get stream => _navigatorHandler.stream;
}
