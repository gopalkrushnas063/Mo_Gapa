import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:ui/model/story.dart';
import 'package:ui/pages/introduction_page.dart';
import 'package:ui/pages/story_details_view.dart';
import 'package:ui/viewmodel/story_view_model.dart';

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

  void shareContent() {
    const String text = "Check out Gopal Story at gopalstory.com";
    const String image = 'assets/images/home_logo.png';

    Share.share(text,
        subject: image,
        sharePositionOrigin: Rect.fromCenter(
            center: const Offset(0, 0), width: 100, height: 100));
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: shareContent,
          ),
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
          statusBarColor:
              Color(0xFFDA8E0B), // Set your desired status bar color
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
                  "“ମୋ ଗପ” ହେଉଛି କାହାଣୀ ଜଗତର ପ୍ରବେଶ ଦ୍ୱାର ଯାହା ବୟସ ପ୍ରତିବନ୍ଧକକୁ ଅତି\nକ୍ରମ କରି ମନୋରଞ୍ଜନ,ନୈତିକତା ଏବଂ ଜ୍ଞାନକୁ ଅନ୍ତର୍ଭୁକ୍ତ କରେ\n",
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
                  Navigator.push(
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
                onTap: shareContent,
              ),
            ],
          ),
        ),
      ),
      body: Consumer<StoryViewModel>(
        builder: (context, storyViewModel, child) {
          if (storyViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (storyViewModel.stories.isEmpty) {
            return const Center(child: Text("No stories available."));
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: storyViewModel.stories.length,
              itemBuilder: (BuildContext context, int index) {
                Story story = storyViewModel.stories[index];

                // Calculate the color index to cycle through the colors
                int colorIndex = index % 5;

                // Define the colors based on the index
                List<Color> colors = [
                  Colors.orange,
                  Colors.green,
                  Colors.indigo,
                  Colors.brown,
                  Colors.red,
                ];

                Color containerColor = colors[colorIndex];

                return GestureDetector(
                  onTap: () {
                    navigateToStoryDetails(story);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
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
