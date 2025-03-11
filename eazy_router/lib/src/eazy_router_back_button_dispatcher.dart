import 'dart:async';

import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';

class EazyRouterBackButtonDispatcher extends RootBackButtonDispatcher {
  EazyRouterBackButtonDispatcher();

  SnackBar? _closeOnDoubleBackSnackBarMessage;
  void setOnDoubleBackButtonCloseMessage(SnackBar closingSnackbar) {
    _closeOnDoubleBackSnackBarMessage = closingSnackbar;
  }

  int _callCount = 0;
  IEazyRouter get _currentRouter =>
      EazyRouterConfiguration.instance.delegate.currentRouter;

  @override
  Future<bool> didPopRoute() async {
    if (_currentRouter.routeStack.last.page.canPop == false) {
      return Future.value(true);
    }
    if (_closeOnDoubleBackSnackBarMessage != null &&
        _currentRouter.routeStack.length == 1) {
      _callCount++;
      if (_callCount == 1) {
        EazyRouterConfiguration.instance.scaffoldMessengerKey.currentState
            ?.showSnackBar(_closeOnDoubleBackSnackBarMessage!);
        await Future.delayed(_closeOnDoubleBackSnackBarMessage!.duration);
      }
      if (_callCount == 2) {
        return false;
      } else {
        _callCount = 0;
        return true;
      }
    }
    if (_currentRouter.routeStack.length == 1) {
      return false;
    }
    return invokeCallback(Future<bool>.value(false));
  }
}
