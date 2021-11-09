import 'package:anime_list_project/pages/search_page.dart';
import 'package:flutter/material.dart';

class MangaSearchPage extends StatefulWidget {
  static const title = 'Search Manga';
  static const routeName = '/manga/search';
  static const endPoint = 'genre/manga';
  static const page = 6;
  const MangaSearchPage({Key? key}) : super(key: key);

  @override
  _MangaSearchPageState createState() => _MangaSearchPageState();
}

class _MangaSearchPageState extends State<MangaSearchPage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return SearchPage(
      args: args,
      title: MangaSearchPage.title,
      endPoint: MangaSearchPage.endPoint,
      page: MangaSearchPage.page,
    );
  }
}