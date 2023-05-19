import 'package:AsianTea/camera/preview_page.dart';
import 'package:AsianTea/screens/home_screen.dart';
import 'package:AsianTea/screens/login_screen.dart';
import 'package:AsianTea/screens/register_screen.dart';
import 'package:AsianTea/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asian Tea Shop',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color(0xFF8A2BE2),
        ),
      ),
      initialRoute: SplashScr.idScreen,
      routes: {
        SplashScr.idScreen:(context) => SplashScr(),
        LoginScreen.idScreen:(context) => LoginScreen(),
        RegisterScreen.idScreen:(context) => RegisterScreen(),
        HomeScreen.idScreen:(context) => HomeScreen(),
        PreviewPage.idScreen:(context) => PreviewPage(),
      },
    );
  }
}
