import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:eazy_router_generator/src/registrar_config_model.dart';
import 'package:eazy_router_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class RegistrarConfigureGenerator
    extends GeneratorForAnnotation<GenerateRoute> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    String pathName = annotation.peek('pathName')?.stringValue ??
        generateRouteNameFromClassName(element.name!);
    final PageModelVisitor visitor = PageModelVisitor();
    element.visitChildren(visitor);
    String routeClassName = '${visitor.className}Route';
    RegistrarConfigModel model = RegistrarConfigModel(
      pathName: pathName,
      routeClassName: routeClassName,
      pageFilePath: buildStep.inputId.path,
      isIinitial: annotation.peek('isInitial')?.boolValue ?? false,
    );
    return model.toJson();
  }
}
