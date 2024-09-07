import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class PageModelVisitor extends SimpleElementVisitor<void> {
  late String className;
  Map<String, String> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.returnType.toString();
    className = className.replaceAll('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields.addAll(
      {
        element.name: element.type.toString().replaceAll('*', ''),
      },
    );
  }
}
