library eazy_router_annotation;

class GenerateRoute {
  final String? pathName;
  final bool isInitial;

  const GenerateRoute({
    this.pathName,
    this.isInitial = false,
  });
}

class QueryParam {
  final String? paramKey;
  const QueryParam([this.paramKey]);
}

class RegisterRoutes {
  const RegisterRoutes();
}
