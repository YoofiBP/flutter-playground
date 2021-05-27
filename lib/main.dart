import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/todolist_screen.dart';
import 'utils/state_management/redux/reducers/app_state_reducer.dart';

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
        title: 'Flutter Demo',
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
          '/': (context) => LoginScreen(),
          '/todo': (context) => TodoListScreen(),
          '/settings': (context) => SettingsScreen()
        },
      ),
    );
  }
}
