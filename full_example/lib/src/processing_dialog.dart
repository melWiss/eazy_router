import 'package:eazy_router/eazy_router.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:flutter/material.dart';

part 'processing_dialog.g.dart';

@GenerateRoute(
  pathName: 'processing',
  canPop: false,
  transition: RouteTransitions.dialog,
)
class ProcessingDialog extends StatelessWidget {
  const ProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text('Processing'),
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
