import 'package:documentation/src/utils/constants.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';

part 'welcome.g.dart';

@GenerateRoute(pathName: 'welcome', parent: homeNavigatorKey)
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome page'),
      ),
    );
  }
}
