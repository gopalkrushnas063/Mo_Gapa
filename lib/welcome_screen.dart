import 'package:flutter/material.dart';
import 'package:ui/features/introduction/view/introduction_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              width: 200,
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
