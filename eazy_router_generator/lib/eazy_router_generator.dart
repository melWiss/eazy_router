library eazy_router_generator;

import 'package:build/build.dart';
import 'package:eazy_router_generator/src/eazy_route_registrar.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateRoute(BuilderOptions options) {
  return SharedPartBuilder(
    [
      EazyRouteGenerator(),
    ],
    'route',
  );
}

Builder registerRoute(BuilderOptions options) {
  return LibraryBuilder(
    EazyRouteRegistrar(),
    generatedExtension: '.registrar.dart',
  );
}
