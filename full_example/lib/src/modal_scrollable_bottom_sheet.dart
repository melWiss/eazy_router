import 'package:flutter/material.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';

part 'modal_scrollable_bottom_sheet.g.dart';

@GenerateBottomSheetRoute(
  isScrollControlled: true,
  showDragHandle: true,
)
class ModalScrollableBottomSheet extends StatelessWidget {
  const ModalScrollableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.1,
      initialChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return ListView.builder(
          itemCount: 100,
          shrinkWrap: true,
          controller: scrollController,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.filter),
            title: Text('Option $index'),
            onTap: () => context.router?.pop(data: index),
          ),
        );
      },
    );
  }
}
