import 'package:flutter/material.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';

part 'modal_scrollable_bottom_sheet.g.dart';

@GenerateBottomSheetRoute(isScrollControlled: true)
class ModalScrollableBottomSheet extends StatelessWidget {
  const ModalScrollableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      shrinkWrap: true,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.filter),
        title: Text('Option $index'),
        onTap: () => context.router?.pop(data: index),
      ),
    );
  }
}
