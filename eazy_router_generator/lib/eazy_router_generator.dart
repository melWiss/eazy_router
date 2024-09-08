library eazy_router_generator;

import 'package:build/build.dart';
import 'package:eazy_router_generator/src/eazy_route_registrar.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:eazy_router_generator/src/registrar_configure.dart';
import 'package:source_gen/source_gen.dart';

Builder generateRoute(BuilderOptions options) {
  return SharedPartBuilder(
    [EazyRouteGenerator()],
    'route',
  );
}

Builder configureRouteRegistrar(BuilderOptions options) {
  return LibraryBuilder(
    RegistrarConfigureGenerator(),
    generatedExtension: '.registrar.json',
    header: '',
    formatOutput: (code) {
      var lines =  code.split('\n');
      lines.removeRange(0, 4);
      return lines.join();
    },
  );
}
Builder registerRoute(BuilderOptions options) {
  return LibraryBuilder(
    EazyRouteRegistrar(),
    generatedExtension: '.routes.dart',
  );
}
