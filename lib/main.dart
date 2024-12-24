import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mogapabahi/features/content/view/content_screen.view.dart';
import 'package:mogapabahi/features/introduction/view/introduction_page.dart';
import 'package:mogapabahi/features/notification/view/notification_screen.dart';
import 'package:mogapabahi/features/story/view/story_details_view.dart';
import 'package:mogapabahi/services/onsignal_service.dart';
import 'package:mogapabahi/welcome_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignalService.initializeOneSignal();
  // OneSignalService.handleNotificationClick();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
    ),
    GoRoute(
      path: '/intro',
      builder: (BuildContext context, GoRouterState state) {
        return const IntroductionPage();
      },
    ),
    // ContentScreen
    GoRoute(
      path: '/content',
      builder: (BuildContext context, GoRouterState state) {
        return const ContentScreen();
      },
    ),
    //StoryDetailsPage
    GoRoute(
      path: '/story',
      builder: (BuildContext context, GoRouterState state) {
        return StoryDetailsPage();
      },
    ),

    //StoryDetailsPage
    GoRoute(
      path: '/story',
      builder: (BuildContext context, GoRouterState state) {
        return  const NotificationScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 218, 142, 11),
    ));

   

    OneSignalService.handleNotificationClick();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mo Gapa Bahi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 218, 142, 11),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
