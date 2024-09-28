import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login.dart';
import 'our_navigation_bar.dart';
import 'register.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

ColorScheme myColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 66, 67, 136));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          brightness: Brightness.light,
          colorScheme: myColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: myColorScheme.primary.withOpacity(.8),
              foregroundColor: Colors.white),
          iconTheme:
              const IconThemeData().copyWith(color: myColorScheme.onPrimary),
          scaffoldBackgroundColor: myColorScheme.primaryFixed),
      debugShowCheckedModeBanner: false,
      initialRoute: "/SplashScreen",
      routes: {
        "/LoginScreen": (_) => const Login(),
        "/HomeScreen": (_) => const OurNavigationbar(),
        "/RegisterScreen": (_) => const Register(),
        "/SplashScreen": (_) => const SplashScreen()
      },
    );
  }
}
