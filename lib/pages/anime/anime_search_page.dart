import 'package:anime_list_project/pages/search_page.dart';
import 'package:flutter/material.dart';

class AnimeSearchPage extends StatefulWidget {
  static const title = 'Search Anime';
  static const routeName = '/anime/search';
  static const endPoint = 'genre/anime';
  static const page = 4;
  const AnimeSearchPage({Key? key}) : super(key: key);

  @override
  _AnimeSearchPageState createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return SearchPage(
      args: args,
      title: AnimeSearchPage.title,
      routeName: AnimeSearchPage.routeName,
      endPoint: AnimeSearchPage.endPoint,
      page: AnimeSearchPage.page,
    );
  }
}
