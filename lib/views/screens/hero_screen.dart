import 'package:flutter/material.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({Key? key}) : super(key: key);

  static const routeName = '/animation';

  @override
  _HeroScreenState createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments ??
        HeroArguments(title: 'Test title');
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Column(
        children: [
          Center(
            child: Hero(
                tag: 'testHero',
                child: Image.network("https://picsum.photos/200")),
          ),
          Text('Title: ${(args as HeroArguments).title}'),
          TextButton(
              onPressed: () {
                Navigator.pop(context, 'This data was sent back');
              },
              child: Text("Send Data back"))
        ],
      ),
    );
  }
}

class HeroArguments {
  final String title;

  HeroArguments({required this.title});
}
