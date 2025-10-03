import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:eazy_router_generator/src/registrar_config_model.dart';
import 'package:eazy_router_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class RegistrarConfigureGenerator
    extends GeneratorForAnnotation<GenerateRoute> {
  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    String pathName = annotation.peek('pathName')?.stringValue ??
        generateRouteNameFromClassName(element.name3!);
    final PageModelVisitor visitor = PageModelVisitor();
    element.visitChildren2(visitor);
    String routeClassName = '${visitor.className}Route';
    RegistrarConfigModel model = RegistrarConfigModel(
      pathName: pathName,
      routeClassName: routeClassName,
      pageFilePath: buildStep.inputId.path,
      isIinitial: annotation.peek('isInitial')?.boolValue ?? false,
      isNotFoundRoute: annotation.peek('isNotFoundRoute')?.boolValue ?? false,
    );
    return model.toJson();
  }
}
