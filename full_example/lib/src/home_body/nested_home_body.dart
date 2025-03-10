// ignore_for_file: overridden_fields

import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:full_example/src/home_body/home_body.dart';
import 'package:flutter/material.dart';

part 'nested_home_body.g.dart';

@GenerateRoute(pathName: 'nested')
class NestedHomeBody extends HomeBody {
  const NestedHomeBody({
    super.key,
    this.router,
    this.title,
  });

  @override
  final IEazyRouter? router;
  @override
  final String? title;
}
