import 'package:anime_list_project/pages/anime/anime_schedule_page.dart';
import 'package:anime_list_project/pages/anime/anime_search_page.dart';
import 'package:anime_list_project/pages/anime/anime_season_page.dart';
import 'package:anime_list_project/pages/anime/anime_top_page.dart';
import 'package:anime_list_project/pages/home/home_page.dart';
import 'package:anime_list_project/pages/manga/manga_search_page.dart';
import 'package:anime_list_project/pages/manga/manga_top_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int page, initialPage;
  final List<Tab>? tabs;
  static const Color focusColor = Colors.blue, defaultColor = Colors.white, backgroundColor = Colors.black;
  static const List<Map<String, dynamic>> pageList = [
    {
      "icon": Icons.home,
      "page" : HomePage.page,
      "title": HomePage.title,
      "routeName": HomePage.routeName,
    },
    {
      "icon": Icons.cloud,
      "page" : AnimeSeasonPage.page,
      "title": AnimeSeasonPage.title,
      "routeName": AnimeSeasonPage.routeName,
    },
    {
      "icon": Icons.date_range,
      "page" : AnimeSchedulePage.page,
      "title": AnimeSchedulePage.title,
      "routeName": AnimeSchedulePage.routeName,
    },
    {
      "icon": Icons.whatshot,
      "page" : AnimeTopPage.page,
      "title": AnimeTopPage.title,
      "routeName": AnimeTopPage.routeName,
    },
    {
      "icon": Icons.search,
      "page" : AnimeSearchPage.page,
      "title": AnimeSearchPage.title,
      "routeName": AnimeSearchPage.routeName,
    },
    {
      "icon": Icons.whatshot,
      "page" : MangaTopPage.page,
      "title": MangaTopPage.title,
      "routeName": MangaTopPage.routeName,
    },
    {
      "icon": Icons.search,
      "page" : MangaSearchPage.page,
      "title": MangaSearchPage.title,
      "routeName": MangaSearchPage.routeName,
    },
  ];

  const MainScaffold({
    Key? key,
    required this.title,
    required this.page,
    required this.body,
    this.tabs,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialPage,
      length: tabs!=null ? tabs!.length : 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: Theme.of(context).textTheme.headline1),
          bottom: tabs==null ? null : TabBar(tabs: tabs!),
          backgroundColor: backgroundColor,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: backgroundColor,
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: backgroundColor),
                  child: Image.asset(
                    'assets/images/drawer_header.jpg',
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                ),
                for(int i=0;i<pageList.length;i++)
                  _buildListTile(context, pageList[i]),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: body,
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, Map pageInfo) {
    return ListTile(
      selectedTileColor: MainScaffold.focusColor,
      hoverColor: MainScaffold.focusColor,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              pageInfo['icon'],
              color: defaultColor,
            ),
          ),
          Text(
            pageInfo['title'],
            style: GoogleFonts.notoSans(color: defaultColor),
          ),
        ],
      ),
      onTap: () {
        if(page != pageInfo['page']) {
          Navigator.pushNamed(
            context,
            pageInfo['routeName'],
          );
        }
        else {
          Navigator.pop(context);
        }
      },
      selected: page == pageInfo['page'],
    );
  }
}
