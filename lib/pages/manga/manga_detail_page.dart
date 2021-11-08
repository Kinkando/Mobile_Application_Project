import 'package:anime_list_project/models/manga.dart';
import 'package:anime_list_project/pages/detail_page.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class MangaDetailPage extends StatefulWidget {
  static const title = 'Manga Detail';
  static const routeName = '/manga/detail';
  const MangaDetailPage({Key? key}) : super(key: key);

  @override
  _MangaDetailPageState createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Manga manga = ModalRoute.of(context)!.settings.arguments as Manga;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MangaDetailPage.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: MainScaffold.backgroundColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: DetailPage(info: manga),
      ),
    );
  }
}
