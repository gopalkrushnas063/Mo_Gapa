import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mogapabahi/features/notification/view/notification_screen.dart';
import 'package:share/share.dart';
import 'package:mogapabahi/data/model/story.dart';
import 'package:mogapabahi/features/content/controller/content.controller.dart';
import 'package:mogapabahi/features/introduction/view/introduction_page.dart';
import 'package:mogapabahi/features/story/view/story_details_view.dart';
import 'package:mogapabahi/utility/enum.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ContentScreen extends ConsumerStatefulWidget {
  const ContentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentScreenState();
}

class _ContentScreenState extends ConsumerState<ContentScreen> {
  late BannerAd _bannerAd;
  bool isBannerAdReady = false;

  late InterstitialAd _interstitialAd;
  bool isInterstitialAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-8558612038787013/3005157077',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(
            () {
              isBannerAdReady = true;
            },
          );
        },
        onAdFailedToLoad: (ad, error) {
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-8558612038787013/1692075405',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(
            () {
              _interstitialAd = ad;
              isInterstitialAdReady = true;
            },
          );
        },
        onAdFailedToLoad: (error) {
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  BannerAd createNewBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-8558612038787013/3005157077',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          setState(() {
            isBannerAdReady = false;
          });
        },
      ),
    )..load();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void navigateToStoryDetails(StoryModel story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryDetailsPage(story: story),
      ),
    );
  }

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

  Future<void> shareContent(BuildContext context) async {
    String text =
        "For more story go to playstore and download\ncom.krishnatechworld.mogapabahi";
    String imageUrl =
        "https://play-lh.googleusercontent.com/lm16K3Mf2KE8FlTrIaumQzk-UiWyiaTJjhr-jchx3MZSZjdv05i_-YRZNOvzKMPKCA=w240-h480-rw";

    if (imageUrl.startsWith('http')) {
      final response = await http.get(Uri.parse(imageUrl));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/image.png');
      await file.writeAsBytes(response.bodyBytes);
      await Share.shareFiles([file.path], text: text);
    } else {
      await Share.shareFiles([imageUrl], text: text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    if (isBannerAdReady) {
      _interstitialAd.dispose();
    }
    super.dispose();
  }

  void _showInterstitialAd() {
    if (isInterstitialAdReady) {
      _interstitialAd.show();
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          setState(() {
            isInterstitialAdReady = false;
          });

          //load new ad
          InterstitialAd.load(
            adUnitId: 'ca-app-pub-8558612038787013/1692075405',
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (ad) {
                setState(
                  () {
                    _interstitialAd = ad;
                    isInterstitialAdReady = true;
                  },
                );
              },
              onAdFailedToLoad: (error) {
                isInterstitialAdReady = false;
              },
            ),
          );
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          setState(() {
            isInterstitialAdReady = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(contentControllerProvider);

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
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ))
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
                      builder: (context) => const IntroductionPage(),
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
              ListTile(
                iconColor: Colors.orange,
                leading: const Icon(Icons.notifications_outlined),
                title: const Text(
                  "ଘୋଷଣା (Notification)",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                },
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       _showInterstitialAd();
              //     },
              //     child: Text("Show Interstital Ad"))
            ],
          ),
        ),
      ),
      body: contentState.status == APIState.loading
          ? const Center(child: CircularProgressIndicator())
          : contentState.status == APIState.failed
              ? const Center(child: Text('Failed to load stories'))
              : contentState.stories != null && contentState.stories!.isNotEmpty
                  ? ListView.builder(
                      itemCount: contentState.stories!.length +
                          (isBannerAdReady
                              ? (contentState.stories!.length / 2).ceil()
                              : 0),
                      itemBuilder: (context, index) {
                        if (isBannerAdReady && index % 3 == 2) {
                          final bannerAd = createNewBannerAd();
                          return SizedBox(
                            height: bannerAd.size.height.toDouble(),
                            width: bannerAd.size.width.toDouble(),
                            child: AdWidget(ad: bannerAd),
                          );
                        }
                        final storyIndex = isBannerAdReady
                            ? index - (index / 3).floor()
                            : index;
                        final story = contentState.stories![storyIndex];
                        int colorIndex = storyIndex %
                            colors.length; // Use length of colors list
                        Color containerColor = colors[colorIndex];

                        return GestureDetector(
                          onTap: () {
                            navigateToStoryDetails(story);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                      Icon(Icons.linear_scale,
                                          color: containerColor),
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
                    )
                  : const Center(
                      child: Text('No stories found'),
                    ),
      bottomNavigationBar: isBannerAdReady
          ? SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : null,
    );
  }
}
