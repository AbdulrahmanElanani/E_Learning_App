import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_1st/firebase_options.dart';
import 'package:project_1st/providers/google_signin.dart';
import 'package:project_1st/screens/verfiy_email.dart';
import 'package:project_1st/shared/snackBar.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'our_navigation_bar.dart';
import 'register.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return  const VerifyEmailPage();
            } else {
              return const Login();
            }
          },
        ),
      ),
    ),
  );
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
