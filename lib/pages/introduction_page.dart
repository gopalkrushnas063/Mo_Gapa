import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  bool doubleBackToExit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (doubleBackToExit) {
          return true;
        } else {
          doubleBackToExit = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press back again to exit"),
            ),
          );

          Future.delayed(Duration(seconds: 2), () {
            doubleBackToExit = false;
          });

          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "ଉପକ୍ରମ",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 218, 142, 11),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
        ),
        body: const Center(
          child: Text("Your Page Content Here"),
        ),
      ),
    );
  }
}
