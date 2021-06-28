import 'package:flutter/material.dart';

class Routes {
  static const home = '/home';
  static const todos = '/todo';
  static const settings = '/settings';
  static const intermediary = '/home/$settings';
  static const list = '/list';
  static const signup = '/signup';
  static const defaultRoute = '/default';
  static const dummyHome = '$defaultRoute/home';
  static const dummy = '$defaultRoute/dummy';

  /* Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget page;
    if (settings.name!.startsWith(home)) {
      final subRoute = settings.name!.substring(home.length);
      page = 
    }
  } */
}
