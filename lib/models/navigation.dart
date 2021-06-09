import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';

class Navigation {
  static Navigation? _instance;
  final GlobalKey<NavigatorState> navigatorKey;

  Navigation._internal() : navigatorKey = GlobalKey<NavigatorState>();

  factory Navigation() {
    if (_instance == null) {
      _instance = Navigation._internal();
    }

    return _instance as Navigation;
  }

  void navigationMiddleware(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is NavigationAction) {
      navigatorKey.currentState?.pushNamed(action.route);
    }
  }
}

Navigation navigation = Navigation();
