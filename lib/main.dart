import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_todo_list/utils/state_management/riverpod/todolistscreen.dart';
import 'package:provider/provider.dart';

import 'containers/login_container.dart';
import 'models/navigation.dart';
import 'utils/routing.dart';
import 'utils/services/todo_service.dart';
import 'utils/state_management/provider/todo_list.dart';
import 'utils/state_management/redux/reducers/app_state_reducer.dart';
import 'views/screens/hero_screen.dart';
import 'views/screens/list_screen.dart';
import 'views/screens/settings_screen.dart';
import 'views/screens/signup_screen.dart';
import 'views/screens/todolist_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
        initialRoute: TodoNewScreen.routeName,
        routes: {
          Routes.home: (context) => LoginContainer(),
          Routes.todos: (context) => TodoListScreen(),
          Routes.settings: (context) => SettingsScreen(),
          Routes.list: (context) => ListScreen(),
          Routes.signup: (context) => SignUpScreen(),
          HeroScreen.routeName: (context) => HeroScreen(),
          TodoNewScreen.routeName: (context) => TodoNewScreen()
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
