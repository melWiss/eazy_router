import 'dart:convert';

class RegistrarConfigModel {
  final String pathName;
  final String routeClassName;
  final String pageFilePath;
  final bool isIinitial;
  final bool isNotFoundRoute;
  RegistrarConfigModel({
    required this.pathName,
    required this.routeClassName,
    required this.pageFilePath,
    required this.isIinitial,
    required this.isNotFoundRoute,
  });

  RegistrarConfigModel copyWith({
    String? pathName,
    String? routeClassName,
    String? pageFilePath,
    bool? isIinitial,
    bool? isNotFoundRoute,
  }) {
    return RegistrarConfigModel(
      pathName: pathName ?? this.pathName,
      routeClassName: routeClassName ?? this.routeClassName,
      pageFilePath: pageFilePath ?? this.pageFilePath,
      isIinitial: isIinitial ?? this.isIinitial,
      isNotFoundRoute: isNotFoundRoute ?? this.isNotFoundRoute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pathName': pathName,
      'routeClassName': routeClassName,
      'pageFilePath': pageFilePath,
      'isIinitial': isIinitial,
      'isNotFoundRoute': isNotFoundRoute,
    };
  }

  factory RegistrarConfigModel.fromMap(Map<String, dynamic> map) {
    return RegistrarConfigModel(
      pathName: map['pathName'] ?? '',
      routeClassName: map['routeClassName'] ?? '',
      pageFilePath: map['pageFilePath'] ?? '',
      isIinitial: map['isIinitial'] ?? false,
      isNotFoundRoute: map['isNotFoundRoute'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrarConfigModel.fromJson(String source) =>
      RegistrarConfigModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrarConfigModel(pathName: $pathName, routeClassName: $routeClassName, pageFilePath: $pageFilePath, isIinitial: $isIinitial, isNotFoundRoute: $isNotFoundRoute)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrarConfigModel &&
        other.pathName == pathName &&
        other.routeClassName == routeClassName &&
        other.pageFilePath == pageFilePath &&
        other.isIinitial == isIinitial &&
        other.isNotFoundRoute == isNotFoundRoute;
  }

  @override
  int get hashCode {
    return pathName.hashCode ^
        routeClassName.hashCode ^
        pageFilePath.hashCode ^
        isIinitial.hashCode ^
        isNotFoundRoute.hashCode;
  }
}
