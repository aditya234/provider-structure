import 'package:flutter/material.dart';
import 'package:providerstatemanage/custom_popup_route.dart';
import 'package:providerstatemanage/navigator_keys.dart';

class LoadingDialog {
  LoadingDialog._();

  static LoadingDialog _instance = LoadingDialog._();

  factory LoadingDialog() => _instance;
  bool _showing = false;

  show() {
    if (!_showing) {
      _showing = true;
      NavigationKeys.globalNavigatorKey.currentState
          .push(CustomPopupRoutes(
              pageBuilder: (_, __, ___) {
                print("building loader");
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              barrierDismissible: false))
          .then((_) {
//        _showing = false;
      });
    }
  }

  hide() {
    print("hide called");
    if (_showing) {
      NavigationKeys.globalNavigatorKey.currentState.pop();
      _showing = false;
    }
  }
}
