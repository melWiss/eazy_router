import 'package:build/build.dart';
import 'package:eazy_router_generator/src/eazy_route_registrar.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:eazy_router_generator/src/modal_bottom_sheet_generator.dart';
import 'package:eazy_router_generator/src/registrar_configure.dart';
import 'package:source_gen/source_gen.dart';

Builder generateRoute(BuilderOptions options) {
  return SharedPartBuilder(
    [EazyRouteGenerator(), ModalBottomSheetGenerator()],
    'route',
  );
}

Builder configureRouteRegistrar(BuilderOptions options) {
  return LibraryBuilder(
    PageRouteRegistrar(),
    generatedExtension: '.registrar.json',
    header: '',
    formatOutput: (code, _) {
      var lines = code.split('\n');
      lines.removeRange(0, 4);
      return lines.join();
    },
  );
}

Builder configureModalBottomSheetRouteRegistrar(BuilderOptions options) {
  return LibraryBuilder(
    ModalBottomSheetRouteRegistrar(),
    generatedExtension: '.modals.json',
    header: '',
    formatOutput: (code, _) {
      var lines = code.split('\n');
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
