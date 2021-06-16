import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<StoryItem> items = List.generate(
      10,
      (index) => StoryItem(
          headline: "Lorem Ipsum is simply dummy text",
          subtitle:
              """The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable Englis""",
          imageSrc: "https://picsum.photos/400/200"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Lists"),
            floating: true,
            expandedHeight: AppBar().preferredSize.height,
            flexibleSpace: Image.network("https://picsum.photos/900/217"),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => StoryItemWidget(story: items[index]),
                  childCount: items.length))
        ],
      ),
    );
  }
}

class StoryItem {
  final String imageSrc;
  final String headline;
  final String subtitle;

  StoryItem(
      {required this.headline, required this.subtitle, required this.imageSrc});
}

class StoryItemWidget extends StatelessWidget {
  final StoryItem story;
  const StoryItemWidget({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            //image
            CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: story.imageSrc),
            //headline
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(story.headline,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            //subtitle
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Align(
                  alignment: Alignment.centerLeft, child: Text(story.subtitle)),
            )
          ],
        ),
      ),
    );
  }
}
