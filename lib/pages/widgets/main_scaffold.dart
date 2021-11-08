import 'package:anime_list_project/pages/anime/anime_schedule_page.dart';
import 'package:anime_list_project/pages/anime/anime_search_page.dart';
import 'package:anime_list_project/pages/anime/anime_season_page.dart';
import 'package:anime_list_project/pages/anime/anime_top_page.dart';
import 'package:anime_list_project/pages/home/home_page.dart';
import 'package:anime_list_project/pages/manga/manga_search_page.dart';
import 'package:anime_list_project/pages/manga/manga_top_page.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int page, initialPage;
  final List<Tab>? tabs;
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
      "icon": Icons.category,
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
          title: Text(title),
          bottom: tabs==null ? null : TabBar(tabs: tabs!),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: Image.asset(
                  'assets/images/drawer_header.jpg',
                  fit: BoxFit.cover,
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
              ),
              _buildListTile(context, pageList[0]),
              ExpansionTile(
                title: Text(
                  'Anime',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: page>=AnimeSeasonPage.page && page<=AnimeSearchPage.page ? Colors.blue : Colors.black,
                  ),
                ),
                children: [
                  for(int i=1;i<=4;i++)
                    _buildListTile(context, pageList[i]),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Manga',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: page>=MangaTopPage.page && page<=MangaSearchPage.page ? Colors.blue : Colors.black,
                  ),
                ),
                children: [
                  for(int i=5;i<=6;i++)
                    _buildListTile(context, pageList[i]),
                ],
              ),
            ],
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
      title: Padding(
        padding: EdgeInsets.all(pageInfo['title'] == HomePage.title ? 0.0 : 8.0),
        child: Text(
          pageInfo['title'],
          style: page == pageInfo['page'] || pageInfo['title'] == HomePage.title
              ? null
              : Theme.of(context).textTheme.bodyText2,
        ),
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
