import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:flutter/material.dart';
import 'package:eazy_router/eazy_router.dart';
part 'bottom_sheet.g.dart';

@GenerateRoute(transition: RouteTransitions.bottomsheet)
class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.teal,
        );
      },
    );
  }
}
