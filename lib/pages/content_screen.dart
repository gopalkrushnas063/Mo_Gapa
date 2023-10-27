import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:ui/pages/content_list.dart';
import 'package:ui/pages/introduction_page.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void shareContent() {
    const String text = "Check out Gopal Story at \n gopalstory.com";
    const String image =
        'assets/images/home_logo.png'; 

    Share.share(
      text,
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
            "ସୂଚୀପତ୍ର",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 218, 142, 11),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 142, 11),
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
                    ));
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
              onTap:
                  shareContent, // Call the shareContent function when the Share App item is clicked
            ),
          ],
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Card(
              margin: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                // Replace makeListTile with your content
                child: makeListTile,
              ),
            ),
          );
        },
      ),
    );
  }
}
