import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:eazy_router_annotation/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class EazyRouteGenerator extends GeneratorForAnnotation<GenerateRoute> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    String pathName = annotation.peek('pathName')?.stringValue ??
        _generateRouteNameFromClassName(element.name!);
    final PageModelVisitor visitor = PageModelVisitor();
    element.visitChildren(visitor);
    final buffer = StringBuffer();
    String routeClassName = '${visitor.className}Route';
    buffer.writeln('class $routeClassName extends MyPageRoute {');
    // state the class fields
    visitor.fields.forEach(
      (key, value) {
        buffer.writeln('final $value $key;');
      },
    );
    buffer.writeln();

    // state the first constructor, the named normal one
    if (visitor.fields.isNotEmpty) {
      buffer.writeln('$routeClassName({');
      visitor.fields.forEach(
        (key, value) {
          buffer.writeln('this.$key,');
        },
      );
      buffer.writeln('});');
    } else {
      buffer.writeln('$routeClassName();');
    }
    buffer.writeln();

    // state the .fromQueryParam constructor
    buffer.writeln(
        'factory $routeClassName.fromQueryParam(Map<String, String>? params) {');
    buffer.writeln('return $routeClassName(');
    visitor.fields.forEach(
      (key, value) {
        if (value.contains('int')) {
          buffer.writeln("$key: int.parse(params?['$key']),");
        } else if (value.contains('double')) {
          buffer.writeln("$key: double.parse(params?['$key']),");
        } else if (value.contains('bool')) {
          buffer.writeln("$key: bool.parse(params?['$key']),");
        } else if (value.contains('String')) {
          buffer.writeln("$key: params?['$key'],");
        } else if (value.contains('List') || value.contains('Map')) {
          buffer.writeln("$key: jsonDecode(params?['$key']),");
        } else if (value.contains('DateTime')) {
          buffer.writeln("$key: DateTime.parse(params?['$key']),");
        } else {
          buffer.writeln('// key=$key,\tvalue=$value');
        }
      },
    );
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln();

    // state the page getter
    buffer.writeln('@override');
    buffer.writeln('Page get page => MaterialPage(');
    buffer.writeln("key: const ValueKey('$pathName'),");
    buffer.writeln("name: '$pathName',");
    buffer.writeln("arguments: queryParameters,");
    buffer.writeln("child: ${visitor.className} (");
    visitor.fields.forEach(
      (key, value) {
        buffer.writeln('$key: $key,');
      },
    );
    buffer.writeln("),");
    buffer.writeln(');');
    buffer.writeln();

    // state the queryParams getter
    buffer.writeln('@override');
    buffer.writeln('Map<String, String> get queryParameters => {');
    visitor.fields.forEach(
      (key, value) {
        if (value.contains('List') || value.contains('Map')) {
          buffer.writeln("if ($key != null) '$key': jsonEncode($key!),");
        } else if (value == 'DateTime') {
          buffer.writeln("if ($key != null) '$key': $key!.toIso8601String(),");
        } else if (['int', 'double', 'String', 'bool']
            .contains(value.replaceFirst('?', ''))) {
          buffer.writeln("if ($key != null) '$key': $key!.toString(),");
        }
      },
    );
    buffer.writeln('};');

    buffer.write('}');
    return buffer.toString();
  }

  String _generateRouteNameFromClassName(String className) {
    var pathName = '';
    for (var char in className.runes) {
      if (char < 'a'.codeUnitAt(0)) {
        pathName += '-${String.fromCharCode(char).toLowerCase()}';
      } else {
        pathName += String.fromCharCode(char);
      }
    }
    List<String> parts = pathName.split('-');
    parts.removeAt(0);
    pathName = parts.join('-');
    return pathName;
  }
}
