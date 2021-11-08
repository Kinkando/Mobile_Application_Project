import 'package:anime_list_project/pages/select_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class AnimeTopPage extends StatefulWidget {
  static const title = 'Top Anime';
  static const routeName = '/anime/top';
  static const endPoint = 'top/anime';
  static const page = 3;
  const AnimeTopPage({Key? key}) : super(key: key);

  @override
  _AnimeTopPageState createState() => _AnimeTopPageState();
}

class _AnimeTopPageState extends State<AnimeTopPage> {
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: AnimeTopPage.title,
      page: AnimeTopPage.page,
      body: SelectPage(routeName: AnimeTopPage.routeName, endPoint: AnimeTopPage.endPoint),
    );
  }
}
