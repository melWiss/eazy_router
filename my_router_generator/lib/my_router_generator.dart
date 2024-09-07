library my_router_generator;

import 'package:build/build.dart';
import 'package:my_router_generator/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateRoute(BuilderOptions options) {
  return SharedPartBuilder(
    [
      MyRouteGenerator(),
    ],
    'route',
  );
}
