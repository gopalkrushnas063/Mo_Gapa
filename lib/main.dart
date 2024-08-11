import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mogapabahi/features/story/view/story_details_view.dart';
import 'package:mogapabahi/services/onsignal_service.dart';
import 'package:mogapabahi/welcome_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignalService.initializeOneSignal();
  OneSignalService.loginUser("ID567");

  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => StoryViewModel(),
    //   child: const MyApp(),
    // ),
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 218, 142, 11),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mo Gapa Bahi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 218, 142, 11),
        ),
        useMaterial3: true,
      ),
      home:  WelcomeScreen(),
      navigatorKey: navigatorKey,
      
    );
  }
}
