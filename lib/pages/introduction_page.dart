import 'package:flutter/material.dart';
import 'package:ui/pages/content_screen.dart';
import 'package:share/share.dart';
import 'package:zoom_widget/zoom_widget.dart';

class IntroductionPage extends StatelessWidget {
  bool doubleBackToExit = false;

  double fontSize = 16.0;

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

          Future.delayed(const Duration(seconds: 2), () {
            doubleBackToExit = false;
          });

          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "ମୋ ଗପ",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 218, 142, 11),
          leading: Container(),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                // Define the content you want to share
                final String textToShare = "Share this text with your friends!";

                // Use the share package to share the content
                Share.share(textToShare);
              },
            ),
          ],
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
          ),
        ),
        body: const Center(
          child: Column(
            children: [
               Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "-: ମୋ ଗପ ବିଷୟରେ ସଂକ୍ଷିପ୍ତ :-",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color.fromARGB(255, 218, 142, 11),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
               Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  " (ମୋ ଗପ) ହେଉଛି ବହୁମୁଖୀ ମୋବାଇଲ୍ ପ୍ରୟୋଗ ଯାହା ସବୁ ବୟସର ପାଠକଙ୍କୁ ଯୋଗାଇବା ପାଇଁ ଡିଜାଇନ୍ ହୋଇଛି ଏହି ପ୍ରୟୋଗଟି କାହାଣୀର ଏକ ଭଣ୍ଡାର ଅଟେ ଯାହା କେବଳ ଚିତ୍ତାକର୍ଷକ ନୁହେଁ ବରଂ ବହୁ ମୂଲ୍ୟବାନ ଜୀବନ ଶିକ୍ଷା ଏବଂ ଜ୍ଞାନ ମଧ୍ୟ ପ୍ରଦାନ କରିଥାଏ | ଏହା ଏକ ପ୍ଲାଟଫର୍ମ ଯେଉଁଠାରେ ଯୁବକ ଏବଂ ବୃଦ୍ଧମାନେ ଏକ ଆକର୍ଷଣୀୟ କାହାଣୀର ଦୁନିଆରେ ପ୍ରବେଶ କରିପାରିବେ ଯାହା କଳ୍ପନାକୁ ଉତ୍ସାହିତ କରିଥାଏ, ନୈତିକ ଜ୍ଞାନ ପ୍ରଦାନ କରିଥାଏ ଏବଂ ଏକ ବ୍ୟାପକ ଜ୍ଞାନ ପ୍ରଦାନ କରିଥାଏ |\n\nମୋ ଗପ ରେ ବର୍ଣ୍ଣିତ କାହାଣୀଗୁଡିକ ମନୋରଞ୍ଜନ, ନୈତିକତା ଏବଂ ଶିକ୍ଷାର ମିଶ୍ରଣ ଅଟେ, ଆପଣ ପିଲା, କିଶୋର କିମ୍ବା ବୟସ୍କ ହୁଅନ୍ତୁ, ଆପଣ କାହାଣୀ ପାଇବେ ଯାହା ଆପଣଙ୍କ ସହିତ ପୁନଃପ୍ରତିରୂପିତ ହେବ ଏବଂ ଆପଣଙ୍କ ଆଗ୍ରହକୁ କାବୁ କରିବ | ଲୋକକଥା ଠାରୁ ଆରମ୍ଭ କରି ଆଧୁନିକ କାହାଣୀଗୁଡିକ ସମସାମୟିକ ପ୍ରସଙ୍ଗଗୁଡିକ ପ୍ରତିଫଳିତ କରେ, (ମୋ ଗପ) ସମସ୍ତଙ୍କ ପାଇଁ କିଛି ଅଛି |\n\nଏହି ମୋବାଇଲ୍ ପ୍ରୟୋଗ ଏହାର ସମସ୍ତ ରୂପରେ କାହାଣୀ କହିବାର ଶକ୍ତିର ଏକ ପ୍ରମାଣ ଅଟେ ଏହା ପାଠକମାନଙ୍କୁ ବିଭିନ୍ନ ଧାରା ଅନୁସନ୍ଧାନ କରିବାକୁ, ଅନ୍ୟମାନଙ୍କ ଅନୁଭୂତିରୁ ଶିଖିବାକୁ ଏବଂ ସର୍ବୋପରି, ଶବ୍ଦର ଯାଦୁ ଦ୍ୱାରା ମନୋରଞ୍ଜନ କରିବାକୁ ସକ୍ଷମ କରିଥାଏ | (ମୋ ଗପ) କେବଳ ମନୋରଞ୍ଜନଠାରୁ ଅଧିକ; ଏହା ବୟସ ସ୍ପେକ୍ଟ୍ରମରେ ପାଠକମାନଙ୍କ ହୃଦୟ ଏବଂ ମନକୁ ଜଡିତ, ଜ୍ଞାନ ଏବଂ ସମୃଦ୍ଧ କରିବାକୁ ଚେଷ୍ଟା କରେ |\n\nଆପଣ ଏକ ନୈତିକ ଶିକ୍ଷା, ହସ, କିମ୍ବା ଏକ ଚିନ୍ତାଧାରା ସୃଷ୍ଟି କରୁଥିବା କାହାଣୀ ଖୋଜୁଛନ୍ତି, “ମୋ ଗପ” ହେଉଛି କାହାଣୀ ଜଗତର ପ୍ରବେଶ ଦ୍ୱାର ଯାହା ବୟସ ପ୍ରତିବନ୍ଧକକୁ ଅତିକ୍ରମ କରି ମନୋରଞ୍ଜନ, ନୈତିକତା ଏବଂ ଜ୍ଞାନକୁ ଅନ୍ତର୍ଭୁକ୍ତ କରେ |",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 218, 142, 11),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentPage(),
                ));
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
