import 'package:anime_list_project/pages/select_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class MangaTopPage extends StatefulWidget {
  static const title = 'Top Manga';
  static const routeName = '/manga/top';
  static const endPoint = 'top/manga';
  static const page = 5;
  const MangaTopPage({Key? key}) : super(key: key);

  @override
  _MangaTopPageState createState() => _MangaTopPageState();
}

class _MangaTopPageState extends State<MangaTopPage> {
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: MangaTopPage.title,
      page: MangaTopPage.page,
      body: SelectPage(routeName: MangaTopPage.routeName, endPoint: MangaTopPage.endPoint),
    );
  }
}
