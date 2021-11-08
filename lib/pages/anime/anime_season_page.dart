import 'package:anime_list_project/pages/select_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class AnimeSeasonPage extends StatefulWidget {
  static const title = 'Seasonal Anime';
  static const routeName = '/anime/season';
  static const endPoint = 'season';
  static const page = 1;
  const AnimeSeasonPage({Key? key}) : super(key: key);

  @override
  _AnimeSeasonPageState createState() => _AnimeSeasonPageState();
}

class _AnimeSeasonPageState extends State<AnimeSeasonPage> {
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: AnimeSeasonPage.title,
      page: AnimeSeasonPage.page,
      body: SelectPage(routeName: AnimeSeasonPage.routeName, endPoint: AnimeSeasonPage.endPoint),
    );
  }
}
