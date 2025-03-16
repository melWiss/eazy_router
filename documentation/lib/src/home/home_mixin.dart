import 'package:documentation/src/setup/installation.dart';
import 'package:documentation/src/welcome/welcome.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';

mixin HomePageHelpersMixin {
  final Map<String, int> _destinationsPathIndex = {
    WelcomePageRoute().page.name!: 0,
    InstallationPageRoute().page.name!: 1,
  };

  final List<EazyRoute> destinationsIndexPath = [
    WelcomePageRoute(),
    InstallationPageRoute(),
  ];

  int getSelectedIndex(String? routeName) =>
      routeName == null ? 0 : _destinationsPathIndex[routeName] ?? 0;

  final List<NavigationDestination> destinations = [
    NavigationDestination(icon: Icon(Icons.home), label: 'Welcome'),
    NavigationDestination(icon: Icon(Icons.settings), label: 'Installation'),
  ];

  List<NavigationRailDestination> get navigationRailDestinations =>
      destinations.map((e) => e.toNavigationRailDestination).toList();
}

extension on NavigationDestination {
  NavigationRailDestination get toNavigationRailDestination =>
      NavigationRailDestination(
        icon: icon,
        label: Text(label),
      );
}
