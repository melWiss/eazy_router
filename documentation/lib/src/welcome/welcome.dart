import 'package:documentation/src/utils/constants.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

part 'welcome.g.dart';

@GenerateRoute(
  pathName: 'welcome',
  parent: homeNavigatorKey,
)
class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final TocController controller = TocController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome page'),
      ),
      body: FutureBuilder<String>(
          future: rootBundle.loadString('assets/README.md'),
          initialData: 'Loading ⏳',
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (index != null) {
                controller.jumpToIndex(index!);
              }
            }
            return Row(
              children: [
                Expanded(child: SizedBox.shrink()),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).height * .69,
                    minWidth: 200
                  ),
                  child: MarkdownWidget(
                    data: snapshot.data ?? '',
                    config: MarkdownConfig.darkConfig.copy(configs: [
                      LinkConfig(
                        onTap: (value) {
                          if (value.startsWith('/')) {
                            context.router?.goTo(Uri.parse(value));
                          } else {
                            launchUrl(Uri.parse(value));
                          }
                        },
                      ),
                    ]),
                    tocController: controller,
                  ),
                ),
                Expanded(
                  child: TocWidget(controller: controller),
                ),
              ],
            );
          }),
    );
  }
}
