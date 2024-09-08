import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/registrar_config_model.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:source_gen/source_gen.dart';

class EazyRouteRegistrar extends GeneratorForAnnotation<RegisterRoutes> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final routeFile = Glob('**/*.registrar.json');
    final files = routeFile.listSync();
    StringBuffer buffer = StringBuffer();
    buffer.writeln("import 'package:eazy_router/eazy_router.dart';");
    for (var file in files) {
      String filePath = file.path;
      filePath = filePath
          .replaceAll('./.dart_tool/build/generated/', '')
          .replaceAll('/lib', '')
          .replaceAll('.registrar.json', '.dart');
      buffer.writeln("import 'package:$filePath';");
    }
    buffer.writeln("void registerRoutes() {");
    for (var element in files) {
      File file = File(element.path);
      RegistrarConfigModel model =
          RegistrarConfigModel.fromJson(file.readAsStringSync());
      buffer.writeln(
          "EazyRouterHandler().registerRoutes({'${model.pathName}': (params) => ${model.routeClassName}.fromQueryParam(params)});");
      if (model.isIinitial) {
        buffer.writeln(
            "EazyRouterHandler().setInitialRoute(${model.routeClassName}());");
      }
    }

    buffer.writeln("}");
    return buffer.toString();
  }
}
