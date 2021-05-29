import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'containers/login_container.dart';

import 'utils/routing.dart';
import 'utils/state_management/redux/reducers/app_state_reducer.dart';
import 'views/screens/settings_screen.dart';
import 'views/screens/todolist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Todo List',
        navigatorKey: navigation.navigatorKey,
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
          ),
        ),
        initialRoute: '/',
        routes: {
          Routes.home: (context) => LoginContainer(),
          Routes.todos: (context) => TodoListScreen(),
          Routes.settings: (context) => SettingsScreen()
        },
      ),
    );
  }
}
