import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_todo_list/views/screens/hero_screen.dart';

import 'containers/login_container.dart';
import 'containers/todolist_container.dart';
import 'models/navigation.dart';
import 'utils/routing.dart';
import 'utils/state_management/redux/reducers/app_state_reducer.dart';
import 'views/screens/list_screen.dart';
import 'views/screens/settings_screen.dart';
import 'views/screens/signup_screen.dart';

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
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => LoginContainer(),
          Routes.todos: (context) => TodoListContainer(),
          Routes.settings: (context) => SettingsScreen(),
          Routes.list: (context) => ListScreen(),
          Routes.signup: (context) => SignUpScreen(),
          HeroScreen.routeName: (context) => HeroScreen()
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en'), const Locale('es')],
      ),
    );
  }
}
