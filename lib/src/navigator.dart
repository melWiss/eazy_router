import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

abstract class IMyNavigatorHandler with ChangeNotifier {
  final Map<String, MyPageRoute Function(Map<String, String>? params)> pages;

  IMyNavigatorHandler({required this.pages});
  void push(Page page);
  void pushPages(List<Page> pages);
  void pop({int times = 1});
  void removePage(Page page, {bool notifyRootWidget = false});
  void removePageByName(String name, {bool notifyRootWidget = false});
  void popUntilTrue(bool Function(Page page) predicate);
  void goTo(Uri uri);
  bool hasPage(String name);
  List<Page> get pageStack;
  Uri get currentUri;
}

class MyNavigatorHandler extends IMyNavigatorHandler {
  List<Page> _state = [];

  MyNavigatorHandler({
    required Page initialPage,
    required super.pages,
  }) {
    _state = [initialPage];
    notifyListeners();
  }
  @override
  void push(Page page) {
    _state = List.from([..._state, page]);
    notifyListeners();
  }

  @override
  void pushPages(List<Page> pages) {
    _state = List.from([..._state, ...pages]);
    notifyListeners();
  }

  @override
  void pop({int times = 1}) {
    _state.removeRange(_state.length - times, _state.length);
    _state = List.from(_state);
    notifyListeners();
  }

  @override
  void popUntilTrue(bool Function(Page page) predicate) {
    while (!predicate(_state.last)) {
      _state.removeLast();
    }
    _state = List.from(_state);
    notifyListeners();
  }

  @override
  void removePage(Page page, {bool notifyRootWidget = false}) {
    if (_state.contains(page)) {
      _state.remove(page);
      if (notifyRootWidget) {
        _state = List.from(_state);
        notifyListeners();
      }
    }
  }

  @override
  void removePageByName(String name, {bool notifyRootWidget = false}) {
    var pageToRemove = _state.firstWhere((element) => element.name == name);
    _state.remove(pageToRemove);
    if (notifyRootWidget) {
      _state = List.from(_state);
      notifyListeners();
    }
  }

  @override
  bool hasPage(String name) => _state.any((element) => element.name == name);

  @override
  void goTo(Uri uri) {
    _state = List.empty(growable: true);
    for (var path in uri.pathSegments) {
      if (pages[path] != null) {
        _state.add(pages[path]!(uri.queryParameters).page);
      }
    }
    if (_state.isEmpty) {
      _state.add(pages.values.first(uri.queryParameters).page);
    }
    notifyListeners();
  }

  @override
  Uri get currentUri {
    String completePath = '';
    Map<String, String> params = {};
    for (var page in _state) {
      completePath += '/${page.name}';
      params.addAll((page.arguments as Map<String, String>?) ?? {});
    }
    return Uri(
      path: completePath,
      queryParameters: params,
    );
  }

  @override
  List<Page> get pageStack => _state;
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
      builder: (_, __) => ListenableBuilder(
        listenable: _navigatorHandler,
        child: Navigator(
          pages: _navigatorHandler.pageStack,
          key: navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name != null &&
                _navigatorHandler.hasPage(settings.name!)) {
              return _navigatorHandler
                  .pages[settings.name]!
                      (settings.arguments as Map<String, String>?)
                  .page
                  .createRoute(context);
            }
            return _navigatorHandler.pages.values
                .first(settings.arguments as Map<String, String>?)
                .page
                .createRoute(context);
          },
          onDidRemovePage: (page) {
            _navigatorHandler.removePage(page, notifyRootWidget: true);
          },
        ),
        builder: (context, child) {
          if (child == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return child;
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
  List<Page> get pageStack => _navigatorHandler.pageStack;
}

abstract class MyPageRoute {
  Map<String, String> get queryParameters;
  Page get page;
}
