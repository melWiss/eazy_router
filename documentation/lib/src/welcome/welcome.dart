import 'package:documentation/src/utils/constants.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

part 'welcome.g.dart';

@GenerateRoute(
  pathName: 'welcome',
  parent: homeNavigatorKey,
)
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome page'),
      ),
      body: FutureBuilder<String>(
          future: rootBundle.loadString('assets/README.md'),
          initialData: 'Loading ⏳',
          builder: (context, snapshot) {
            return Row(
              children: [
                Expanded(child: SizedBox.shrink()),
                Expanded(
                  flex: 2,
                  child: Markdown(
                    data: snapshot.data ?? '',
                    extensionSet: md.ExtensionSet(
                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                      <md.InlineSyntax>[
                        md.EmojiSyntax(),
                        ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
              ],
            );
          }),
    );
  }
}
