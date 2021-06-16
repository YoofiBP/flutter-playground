import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/settings.dart';
import '../../utils/routing.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settings ?? 'Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.from(settingsItems.map((e) => SettingsCard(
                    title: e["title"] as String, icon: e["icon"] as IconData))),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.list);
                },
                child: Text('Go to Lists')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.signup);
                },
                child: Text('Go to Sign Up')),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.from(settingsItems.map((e) => SettingsCard(
                    title: e["title"] as String, icon: e["icon"] as IconData))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsCard({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        child: Column(
          children: [
            //image
            Expanded(
                child: Icon(
              icon,
              size: 100,
              color: Colors.blue,
            )),
            //Text
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
