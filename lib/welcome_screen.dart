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
      body: SingleChildScrollView(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1), // Adjust the duration as needed
          opacity: _opacity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 55),
                Image.asset(
                  "assets/images/home_logo.png",
                  width: 200,
                ),
                const SizedBox(height: 10),
                const Text(
                  "ମୋ ଗପ ବହି",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 218, 142, 11),
                  ),
                ),
                const SizedBox(height: 8),
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
                          transform:
                              Matrix4.rotationY(3.141), // Rotate 180 degrees
                          child: Image.asset(
                            "assets/images/celebration.gif",
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                const Text(
                  "ଆସ ଆମେ ପଢିବା ଆମ ପିଲାଦିନ ଗପ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 250,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroductionPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 218, 142, 11),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ଆସନ୍ତୁ ଆଗକୁ ବଢ଼ିବା",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
