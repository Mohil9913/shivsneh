import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shivsneh/firebase_options.dart';
import 'package:shivsneh/screens/auth/user_login_screen.dart';
import 'package:shivsneh/screens/other/splash_screen.dart';
import 'package:shivsneh/widgets/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(
    const MyApp(),
  );
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    180,
    255,
    151,
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true).copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          197,
          197,
          197,
        ),
      ),
      // home: const BottomNavbar(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const BottomNavbar();
          } else {
            return const UserLoginScreen();
          }
        },
      ),
    );
  }
}
