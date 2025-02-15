import 'dart:convert';

import 'package:flutter/foundation.dart';

class EazyRouteState {
  final String path;
  final Map<String, String>? params;
  EazyRouteState({
    required this.path,
    this.params,
  });

  EazyRouteState copyWith({
    String? path,
    Map<String, String>? params,
    String? pathId,
  }) {
    return EazyRouteState(
      path: path ?? this.path,
      params: params ?? this.params,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'params': params,
    };
  }

  factory EazyRouteState.fromMap(Map<String, dynamic> map) {
    return EazyRouteState(
      path: map['path'] ?? '',
      params: Map<String, String>.from(map['params']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EazyRouteState.fromJson(String source) =>
      EazyRouteState.fromMap(json.decode(source));

  @override
  String toString() => 'EazyRouteState(path: $path, params: $params)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EazyRouteState &&
        other.path == path &&
        mapEquals(other.params, params);
  }

  @override
  int get hashCode => path.hashCode ^ params.hashCode;

  factory EazyRouteState.fromUri(Uri uri) {
    return EazyRouteState(
      path: uri.path,
      params: uri.queryParameters,
    );
  }

  Uri toUri() {
    return Uri(
      path: path,
      queryParameters: params,
    );
  }
}