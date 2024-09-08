import 'dart:convert';

class RegistrarConfigModel {
  final String pathName;
  final String routeClassName;
  final String pageFilePath;
  final bool isIinitial;
  RegistrarConfigModel({
    required this.pathName,
    required this.routeClassName,
    required this.pageFilePath,
    required this.isIinitial,
  });

  RegistrarConfigModel copyWith({
    String? pathName,
    String? routeClassName,
    String? pageFilePath,
    bool? isIinitial,
  }) {
    return RegistrarConfigModel(
      pathName: pathName ?? this.pathName,
      routeClassName: routeClassName ?? this.routeClassName,
      pageFilePath: pageFilePath ?? this.pageFilePath,
      isIinitial: isIinitial ?? this.isIinitial,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pathName': pathName,
      'routeClassName': routeClassName,
      'pageFilePath': pageFilePath,
      'isIinitial': isIinitial,
    };
  }

  factory RegistrarConfigModel.fromMap(Map<String, dynamic> map) {
    return RegistrarConfigModel(
      pathName: map['pathName'] ?? '',
      routeClassName: map['routeClassName'] ?? '',
      pageFilePath: map['pageFilePath'] ?? '',
      isIinitial: map['isIinitial'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrarConfigModel.fromJson(String source) =>
      RegistrarConfigModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrarConfigModel(pathName: $pathName, routeClassName: $routeClassName, pageFilePath: $pageFilePath, isIinitial: $isIinitial)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrarConfigModel &&
        other.pathName == pathName &&
        other.routeClassName == routeClassName &&
        other.pageFilePath == pageFilePath &&
        other.isIinitial == isIinitial;
  }

  @override
  int get hashCode {
    return pathName.hashCode ^
        routeClassName.hashCode ^
        pageFilePath.hashCode ^
        isIinitial.hashCode;
  }
}
