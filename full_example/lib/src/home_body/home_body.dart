import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';
import 'package:full_example/src/home_body/home_body_state.dart';

abstract class HomeBody extends StatefulWidget {
  const HomeBody({
    this.router,
    this.title,
    super.key,
  });
  final IEazyRouter? router;
  final String? title;

  @override
  State<HomeBody> createState() => HomeBodyState();
}

