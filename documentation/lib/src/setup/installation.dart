import 'package:documentation/src/utils/constants.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
part 'installation.g.dart';

@GenerateRoute(pathName: 'installation', parent: homeNavigatorKey)
class InstallationPage extends StatelessWidget {
  const InstallationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Installation page'),),
    );
  }
}