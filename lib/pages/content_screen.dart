import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:ui/model/story.dart';
import 'package:ui/pages/introduction_page.dart';
import 'package:ui/pages/story_details_view.dart';
import 'package:ui/viewmodel/story_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void navigateToStoryDetails(Story story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryDetailsPage(story: story),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch data from the API when the page is initialized
    Provider.of<StoryViewModel>(context, listen: false).fetchDataFromApi();
  }

  Future<void> shareContent(BuildContext context) async {
    String text =
        "For more story go to playstore and download\ncom.krishnatechworld.mogapabahi";
    String imageUrl =
        "https://play-lh.googleusercontent.com/lm16K3Mf2KE8FlTrIaumQzk-UiWyiaTJjhr-jchx3MZSZjdv05i_-YRZNOvzKMPKCA=w240-h480-rw";

    if (imageUrl.startsWith('http')) {
      // Download the image file to local storage
      final response = await http.get(Uri.parse(imageUrl));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/image.png');
      await file.writeAsBytes(response.bodyBytes);

      // Share the image file
      await Share.shareFiles([file.path], text: text);
    } else {
      // If it's a local image, directly share it
      await Share.shareFiles([imageUrl], text: text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storyViewModel = Provider.of<StoryViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "ସୂଚୀପତ୍ର",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFFDA8E0B),
        leading: IconButton(
          icon: const Icon(
            Icons.dashboard,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
                  await shareContent(context);
                }, 
            icon: Icon(Icons.share,color: Colors.white,)
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      drawer: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFDA8E0B),
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFDA8E0B),
                ),
                accountName: Center(
                  child: Text(
                    "ମୋ ଗପ",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                accountEmail: Text(
                  "“ମୋ ଗପ” ହେଉଛି କାହାଣୀ ଜଗତର ପ୍ରବେଶ ଦ୍ୱାର ଯାହ ବୟସ ପ୍ରତିବନ୍ଧକକୁ ଅତି\nକ୍ରମ କରି ମନୋରଞ୍ଜନ,ନୈତିକତା ଏବଂ ଜ୍ଞାନକୁ ଅନ୍ତର୍ଭୁକ୍ତ କରେ\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              ListTile(
                iconColor: Colors.orange,
                title: const Text(
                  "ମୋ ଗପ ବିଷୟରେ ସଂକ୍ଷିପ୍ତ (About Us)",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroductionPage(),
                    ),
                  );
                },
                leading: const Icon(Icons.info_outline_rounded),
              ),
              ListTile(
                iconColor: Colors.orange,
                leading: const Icon(Icons.share),
                title: const Text(
                  "ସେୟାର୍ ଆପ୍ (Share App)",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                onTap: () async {
                  await shareContent(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer<StoryViewModel>(
        builder: (context, storyViewModel, child) {
          if (storyViewModel.isLoading) {
            return Center(
                child: SizedBox(
              width: 300,
              height: 8,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 218, 142, 11)),
              ),
            ));
          } else if (storyViewModel.stories.isEmpty) {
            return const Center(child: Text("No stories available."));
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: storyViewModel.stories.length,
              itemBuilder: (BuildContext context, int index) {
                Story story = storyViewModel.stories[index];
                int colorIndex = index % 14;
                List<Color> colors = [
                  Colors.orange,
                  Colors.green,
                  Colors.indigo,
                  Colors.brown,
                  Colors.red,
                  Colors.blue,
                  Colors.redAccent,
                  Colors.lime,
                  Colors.pink,
                  Colors.blueGrey,
                  const Color.fromARGB(255, 58, 162, 13)
                ];
                Color containerColor = colors[colorIndex];

                return GestureDetector(
                  onTap: () {
                    navigateToStoryDetails(story);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Card(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 1.0,
                                  color: containerColor,
                                ),
                              ),
                            ),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  containerColor, BlendMode.srcIn),
                              child: Image.network(
                                story.icon,
                                width: 38,
                                height: 38,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.error_outline,
                                    color: containerColor,
                                    size: 38,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            story.title,
                            style: TextStyle(
                              color: containerColor,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(Icons.linear_scale, color: containerColor),
                              Text(
                                story.type,
                                style: TextStyle(
                                  color: containerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          trailing: Icon(
                            Icons.fast_forward,
                            color: containerColor,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
