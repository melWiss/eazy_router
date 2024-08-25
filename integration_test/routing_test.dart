import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // write your widget tests here
  testWidgets(
    'sample integration test',
    (tester) async {
      const widget = HelloIntegrationTest();
      await tester.pumpWidget(widget);
      await tester.pumpFrames(widget, Durations.extralong4);
      expect(0, 0);
    },
  );
}

class HelloIntegrationTest extends StatelessWidget {
  const HelloIntegrationTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello integration test"),
        ),
        body: const Center(
          child: Text("Scaffold body"),
        ),
      ),
    );
  }
}
