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

  bool shouldPop = false;
  String title = "Default route";

  Future<bool> _onRequestExit() async {
    var result = await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('Are you sure you want to exit?'),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                )
              ],
            ));
    return result;
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text(title),
      );

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/dummy') {
      setState(() {
        title = 'Dummy Route';
      });
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Column(
                  children: [
                    TextButton(
                        onPressed: _navigateToDefault,
                        child: Text('Navigate to Default')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Pop'))
                  ],
                ),
              ));
    }
    if (settings.name == '/home') {
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Column(
                  children: [
                    TextButton(
                        onPressed: _navigateToDummy,
                        child: Text('Navigate to Dummy')),
                  ],
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onRequestExit,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: _onGenerateRoute,
          initialRoute: widget.route,
        ),
      ),
    );
  }
}
