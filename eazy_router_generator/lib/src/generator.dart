import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router_generator/src/utils/strings.dart';
import 'package:eazy_router_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class EazyRouteGenerator extends GeneratorForAnnotation<GenerateRoute> {
  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    String pathName = annotation.peek('pathName')?.stringValue ??
        generateRouteNameFromClassName(element.name3!);
    String transition =
        annotation.peek('transition')?.stringValue ?? 'AdaptivePage';
    String? parent = annotation.peek('parent')?.stringValue;
    bool canPop = annotation.peek('canPop')?.boolValue ?? true;
    bool isAnonymous = annotation.peek('isAnonymous')?.boolValue ?? false;
    bool isInitial = annotation.peek('isInitial')?.boolValue ?? false;
    bool showDragHandle = annotation.peek('showDragHandle')?.boolValue ?? false;
    List<DartObject>? guards = annotation.peek('guards')?.listValue;
    final PageModelVisitor visitor = PageModelVisitor();
    element.visitChildren2(visitor);
    final buffer = StringBuffer();
    String routeClassName = '${visitor.className}Route';
    buffer.writeln('class $routeClassName extends EazyRoute {');
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
        if (value.equal('int')) {
          buffer.writeln("$key: int.parse(params?['$key']),");
        } else if (value.equal('double')) {
          buffer.writeln("$key: double.parse(params?['$key']),");
        } else if (value.equal('bool')) {
          buffer.writeln("$key: bool.parse(params?['$key']),");
        } else if (value.equal('String')) {
          buffer.writeln("$key: params?['$key'],");
        } else if (value.equal('List') || value.equal('Map')) {
          buffer.writeln("$key: jsonDecode(params?['$key']),");
        } else if (value.equal('DateTime')) {
          buffer.writeln("$key: DateTime.parse(params?['$key']),");
        }
      },
    );
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln();

    // state the page getter
    buffer.writeln('@override');
    buffer.writeln('Page get page => $transition(');
    buffer.writeln("key: ValueKey('$pathName~\$hashCode'),");
    buffer.writeln("name: '$pathName',");
    buffer.writeln("arguments: queryParameters,");
    buffer.writeln("canPop: $canPop,");
    if (transition == RouteTransitions.bottomsheet) {
      buffer.writeln("showDragHandle: $showDragHandle,");
    }
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
    if (guards?.isNotEmpty == true) {
      buffer.writeln('@override');
      buffer.writeln('List<EazyRouteGuard> get guards => [');
      for (var guard in guards!) {
        buffer.writeln('${guard.type?.getDisplayString()}(),');
      }
      buffer.writeln('];');
    }
    if (isAnonymous) {
      buffer.writeln('@override');
      buffer.writeln('bool get isAnonymous => $isAnonymous;');
    }
    if (isInitial) {
      buffer.writeln('@override');
      buffer.writeln('bool get isInitial => $isInitial;');
    }
    if (parent != null) {
      buffer.writeln('@override');
      buffer.writeln("String get parent => '$parent';");
    }

    buffer.write('}');
    return buffer.toString();
  }
}

String generateRouteNameFromClassName(String className) {
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
