import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:ui/model/story.dart';

class StoryDetailsPage extends StatelessWidget {
  final Story story;

  StoryDetailsPage({super.key, required this.story});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void shareContent() {
    const String text = "Check out Gopal Story at \n gopalstory.com";
    const String image = 'assets/images/home_logo.png';

    Share.share(text,
        subject: image,
        sharePositionOrigin:
            Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "ସମ୍ପୂର୍ଣ କାହାଣୀ",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 218, 142, 11),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  story.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (story.image.isNotEmpty)
                Image.network(
                  story.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              else
                Image.asset(
                  'assets/images/home_banner_2.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                story.content,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 218, 142, 11),
        onPressed: shareContent,
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
    );
  }
}
