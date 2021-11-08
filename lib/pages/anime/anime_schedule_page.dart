import 'package:anime_list_project/pages/select_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class AnimeSchedulePage extends StatefulWidget {
  static const title = 'Schedule Anime';
  static const routeName = '/anime/schedule';
  static const endPoint = 'schedule';
  static const page = 2;
  const AnimeSchedulePage({Key? key}) : super(key: key);

  @override
  _AnimeSchedulePageState createState() => _AnimeSchedulePageState();
}

class _AnimeSchedulePageState extends State<AnimeSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: AnimeSchedulePage.title,
      page: AnimeSchedulePage.page,
      body: SelectPage(routeName: AnimeSchedulePage.routeName, endPoint: AnimeSchedulePage.endPoint),
    );
  }
}
