import 'package:documentation/src/home/home_mixin.dart';
import 'package:documentation/src/search/search.dart';
import 'package:documentation/src/utils/colors.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';

class DesktopHomeBody extends StatelessWidget with HomePageHelpersMixin {
  DesktopHomeBody({
    required this.child,
    required this.constraints,
    super.key,
  });
  final Widget child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 256,
          child: NavigationRail(
            destinations: navigationRailDestinations,
            trailing: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Material(
                borderRadius: BorderRadius.circular(45),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => context.router?.parent?.push(SearchDialogRoute()),
                  child: IgnorePointer(
                    child: Hero(
                      tag: 'search',
                      child: SearchField(),
                    ),
                  ),
                ),
              ),
            ),
            extended: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.settings),
                  Text('EazyRouter documentation'),
                ],
              ),
            ),
            // trailing: SearchButton(),
            backgroundColor:
                Theme.of(context).navigationBarTheme.backgroundColor,
            selectedIndex: getSelectedIndex(
              context.router?.routeStack.first.page.name,
            ),
            onDestinationSelected: (value) {
              context.router?.replaceRoutes([destinationsIndexPath[value]]);
            },
          ),
        ),
        Expanded(
          child: Container(
            color: backgroundColor,
            padding: EdgeInsets.all(5),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(5),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.autoFocus = false,
    this.hintText = 'Search...',
  });

  final bool autoFocus;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      autofocus: autoFocus,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          gapPadding: 20,
        ),
      ),
    );
  }
}
