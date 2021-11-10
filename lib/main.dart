import 'dart:async';

import 'package:anime_list_project/pages/detail_page.dart';
import 'package:anime_list_project/pages/search_page.dart';
import 'package:anime_list_project/pages/select_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:anime_list_project/pages/home_page.dart';
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
          headline1: GoogleFonts.notoSans(fontSize: 24.0, color: MainScaffold.defaultColor, fontWeight: FontWeight.bold),
          bodyText1: GoogleFonts.notoSans(fontSize: 14.0, color: MainScaffold.defaultColor, fontWeight: FontWeight.bold),
          bodyText2: GoogleFonts.notoSans(fontSize: 14.0, color: MainScaffold.defaultColor),
        ),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        pageList['home']!.routeName: (context) => HomePage(),
        pageList['seasonal_anime']!.routeName: (context) => SelectPage(pageDetail: pageList['seasonal_anime']!),
        pageList['schedule_anime']!.routeName: (context) => SelectPage(pageDetail: pageList['schedule_anime']!),
        pageList['top_anime']!.routeName: (context) => SelectPage(pageDetail: pageList['top_anime']!),
        pageList['top_manga']!.routeName: (context) => SelectPage(pageDetail: pageList['top_manga']!),
        pageList['search_anime']!.routeName: (context) => SearchPage(pageDetail: pageList['search_anime']!),
        pageList['search_manga']!.routeName: (context) => SearchPage(pageDetail: pageList['search_manga']!),
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
          () => Navigator.pushReplacementNamed(context, pageList['home']!.routeName),
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