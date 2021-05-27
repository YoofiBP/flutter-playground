import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigatorKey;

  Navigation() : navigatorKey = GlobalKey<NavigatorState>();

  void navigationMiddleware(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is NavigationAction) {
      navigatorKey.currentState?.pushNamed(action.route);
    }
  }
}
