import 'package:anime_list_project/pages/anime/anime_detail_page.dart';
import 'package:anime_list_project/pages/anime/anime_schedule_page.dart';
import 'package:anime_list_project/pages/anime/anime_search_page.dart';
import 'package:anime_list_project/pages/anime/anime_season_page.dart';
import 'package:anime_list_project/pages/anime/anime_top_page.dart';
import 'package:anime_list_project/pages/manga/manga_detail_page.dart';
import 'package:anime_list_project/pages/manga/manga_search_page.dart';
import 'package:anime_list_project/pages/manga/manga_top_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:anime_list_project/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HomePage.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: GoogleFonts.notoSans(fontSize: 24.0, color: MainScaffold.defaultColor, fontWeight: FontWeight.bold),
          bodyText1: GoogleFonts.notoSans(fontSize: 14.0, color: MainScaffold.defaultColor, fontWeight: FontWeight.bold),
          bodyText2: GoogleFonts.notoSans(fontSize: 14.0, color: MainScaffold.defaultColor),
        ),
      ),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AnimeSeasonPage.routeName: (context) => const AnimeSeasonPage(),
        AnimeSchedulePage.routeName: (context) => const AnimeSchedulePage(),
        AnimeTopPage.routeName: (context) => const AnimeTopPage(),
        AnimeSearchPage.routeName: (context) => const AnimeSearchPage(),
        AnimeDetailPage.routeName: (context) => const AnimeDetailPage(),
        MangaTopPage.routeName: (context) => const MangaTopPage(),
        MangaSearchPage.routeName: (context) => const MangaSearchPage(),
        MangaDetailPage.routeName: (context) => const MangaDetailPage(),
      },
      initialRoute: HomePage.routeName, //หน้าเริ่มต้น
    );
  }
}