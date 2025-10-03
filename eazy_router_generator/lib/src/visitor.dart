import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/visitor2.dart';

class PageModelVisitor extends SimpleElementVisitor2<void> {
  late String className;
  Map<String, String> fields = {};

  @override
  void visitConstructorElement(ConstructorElement2 element) {
    className = element.returnType.toString();
    className = className.replaceAll('*', '');
  }

  @override
  void visitFieldElement(FieldElement2 element) {
    if (element.name3 == null) return;
    fields.addAll(
      {
        element.name3!: element.type.toString().replaceAll('*', ''),
      },
    );
  }
}
