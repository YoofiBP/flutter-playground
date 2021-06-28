import 'package:flutter/material.dart';
import 'package:new_todo_list/utils/routing.dart';

class NestNavigationScreen extends StatefulWidget {
  const NestNavigationScreen({Key? key, required this.route}) : super(key: key);

  final String route;

  @override
  _NestNavigationScreenState createState() => _NestNavigationScreenState();
}

class _NestNavigationScreenState extends State<NestNavigationScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _navigateToDefault() {
    _navigatorKey.currentState!.pushNamed('/home');
  }

  void _navigateToDummy() {
    _navigatorKey.currentState!.pushNamed('/dummy');
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/dummy') {
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Dummy Route'),
                ),
                body: Column(
                  children: [
                    TextButton(
                        onPressed: _navigateToDefault,
                        child: Text('Navigate to Default'))
                  ],
                ),
              ));
    }
    if (settings.name == '/home') {
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Default Route'),
                ),
                body: Column(
                  children: [
                    TextButton(
                        onPressed: _navigateToDummy,
                        child: Text('Navigate to Dummy'))
                  ],
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      initialRoute: widget.route,
    );
  }
}
