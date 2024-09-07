import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/generator.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:source_gen/source_gen.dart';

class EazyRouteRegistrar extends GeneratorForAnnotation<RegisterRoutes> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final routeFile = Glob('.dart_tool/**/*.route.g.part');
    final files = routeFile.listSync();
    StringBuffer buffer = StringBuffer();
    buffer.writeln("import 'package:eazy_router/eazy_router.dart';");
    for (var file in files) {
      String filePath = file.path;
      filePath = filePath
          .replaceAll('./.dart_tool/build/generated/', '')
          .replaceAll('/lib', '')
          .replaceAll('.route.g.part', '.dart');
      buffer.writeln("import 'package:$filePath';");
    }
    buffer.writeln("void \$_registerRoutes() {");
    for (var element in files) {
      File file = File(element.path);
      List<String> strings = file.readAsLinesSync();
      buffer.writeln("// ${element.path}");
      String className = strings
          .firstWhere((element) => element.startsWith('class '))
          .trim()
          .replaceAll('class ', '')
          .replaceAll('extends EazyRoute {', '')
          .trim();
      String pathName = strings
          .firstWhere((element) => element.contains("name: '"))
          .trim()
          .replaceAll("name: ", "")
          .replaceAll("'", "")
          .replaceAll(",", "")
          .trim();
      buffer.writeln(
          "EazyRouterHandler().registerRoutes({'$pathName': (params) => $className.fromQueryParam(params)});");
    }

    buffer.writeln("}");
    return buffer.toString();
  }
}
