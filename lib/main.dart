import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickride/intro/splashscreen/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "-q9Y6swm32ihwRSyCTG9itv_8",
          appId: "1:11513534:web:1c8047bbcda011ec7bc42c",
          messagingSenderId: "quickride-9c5296b",
          projectId: "flutter-firebase-ac3bd"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickRide',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
