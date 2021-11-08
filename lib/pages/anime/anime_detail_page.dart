import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/pages/detail_page.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  static const title = 'Anime Detail';
  static const routeName = '/anime/detail';
  const AnimeDetailPage({Key? key}) : super(key: key);

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Anime anime = ModalRoute.of(context)!.settings.arguments as Anime;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnimeDetailPage.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: DetailPage(info: anime),
      ),
    );
  }
}