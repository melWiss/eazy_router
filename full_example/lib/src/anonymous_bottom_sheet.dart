import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
part 'anonymous_bottom_sheet.g.dart';

@GenerateRoute(transition: RouteTransitions.bottomsheet, isAnonymous: true)
class AnonymousBottomSheet extends StatelessWidget {
  const AnonymousBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.filter_1),
              title: const Text('Option 1'),
              onTap: () => context.router?.pop(data: 1),
            ),
            ListTile(
              leading: const Icon(Icons.filter_2),
              title: const Text('Option 2'),
              onTap: () => context.router?.pop(data: 2),
            ),
            ListTile(
              leading: const Icon(Icons.filter_3),
              title: const Text('Option 3'),
              onTap: () => context.router?.pop(data: 3),
            ),
            ListTile(
              leading: const Icon(Icons.filter_4),
              title: const Text('Option 4'),
              onTap: () => context.router?.pop(data: 4),
            ),
            ListTile(
              leading: const Icon(Icons.filter_5),
              title: const Text('Option 5'),
              onTap: () => context.router?.pop(data: 5),
            ),
          ],
        );
      },
    );
  }
}
