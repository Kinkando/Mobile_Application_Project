import 'dart:async';
import 'package:anime_list_project/pages/detail_page.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:anime_list_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const appName = 'Unikume';
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: GoogleFonts.notoSans(fontSize: 24.0, color: HomePage.defaultColor, fontWeight: FontWeight.bold),
          bodyText1: GoogleFonts.notoSans(fontSize: 14.0, color: HomePage.defaultColor, fontWeight: FontWeight.bold),
          bodyText2: GoogleFonts.notoSans(fontSize: 14.0, color: HomePage.defaultColor),
        ),
      ),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        pageList['detail_anime']!.routeName: (context) => DetailPage(pageDetail: pageList['detail_anime']!),
        pageList['detail_manga']!.routeName: (context) => DetailPage(pageDetail: pageList['detail_manga']!),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}