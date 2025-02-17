import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class EazyRoute {
  Map<String, String> get queryParameters;
  Page get page;
}
