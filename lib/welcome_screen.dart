import 'package:flutter/material.dart';
import 'package:ui/pages/introduction_page.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 0.0; // Initial opacity value

  @override
  void initState() {
    super.initState();
    // Add a delay and then animate the opacity
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; // Set opacity to 1 for a fade-in effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/home_logo.png",
            ),
            const Text(
              "ମୋ ଗପ ବହି",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                
              ),
              
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/energi-energy.gif",
                  width: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/celebration.gif",
                      width: 70,
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.141),
                      child: Image.asset(
                        "assets/images/celebration.gif",
                        width: 70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              "ଆସ ଆମେ ପଢିବା ଆମ ପିଲାଦିନ ଗପ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),  
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntroductionPage(),
                  ),
                );
              },
              child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 200, 132, 8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ଆସନ୍ତୁ ଆଗକୁ ବଢ଼ିବା",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
