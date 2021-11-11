import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/models/genre.dart';
import 'package:anime_list_project/models/manga.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final PageInfo pageDetail;
  static final _scrollController = ScrollController();
  const DetailPage({Key? key, required this.pageDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageDetail.title,
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          controller: _scrollController,
          children: [
            Card(
              color: MainScaffold.backgroundColor.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: args is Anime ? _buildAnimeContent(context, args)
                    : _buildMangaContent(context, args as Manga),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildAnimeContent(BuildContext context, Anime anime) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: Image.network(
              anime.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildText(context, 'Title', anime.title),
        _buildText(context, 'Type', anime.type),
        _buildText(context, 'Score', anime.score.toString()),
        _buildText(context, 'Source', anime.source),
        _buildText(context, 'Episode', anime.episodes.toString()),
        _buildText(context, 'On Air', anime.airingStart),
        _buildText(context, 'Start Date', anime.startDate),
        _buildText(context, 'End Date', anime.endDate),
        if (anime.genres != null)
          _buildGenreText(
            anime.genres!, context,
            anime.genres != null && anime.genres!.isNotEmpty,
          ),
        _buildText(context, 'Synopsis', anime.synopsis),
      ],
    );
  }

  Column _buildMangaContent(BuildContext context, Manga manga) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: Image.network(
              manga.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildText(context, 'Title', manga.title),
        _buildText(context, 'Type', manga.type),
        _buildText(context, 'Volume', manga.volumes.toString()),
        _buildText(context, 'Score', manga.score.toString()),
        _buildText(context, 'Publishing Start', manga.publishingStart),
        _buildText(context, 'Start Date', manga.startDate),
        _buildText(context, 'End Date', manga.endDate),
        if (manga.genres != null)
          _buildGenreText(
            manga.genres!, context,
            manga.genres != null && manga.genres!.isNotEmpty,
          ),
        _buildText(context, 'Synopsis', manga.synopsis),
      ],
    );
  }

  Widget _buildText(BuildContext context, String title, String? content) {
    return content == null ? const SizedBox.shrink() : Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(text: content, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }

  Padding _buildGenreText(List<Genre> genre, BuildContext context, bool identify) {
    return Padding(
      padding: !identify ? const EdgeInsets.only(bottom: 8.0) : const EdgeInsets.only(),
      child: Wrap(
        children: [
          Text('Genre: ', style: Theme.of(context).textTheme.bodyText1),
          if (identify)
            for(int i=0;i<genre.length;i++)
              _buildGenreButton(genre[i], context),
          if (!identify)
            Text('Unknown', style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  Padding _buildGenreButton(Genre genre, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            genre.type == 'anime' ? pageList['search_anime']!.routeName : pageList['search_manga']!.routeName,
            arguments: genre,
          );
        },
        child: Text(genre.name, style: GoogleFonts.notoSans(color: MainScaffold.backgroundColor)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(10, 10),
          primary: MainScaffold.defaultColor,
        ),
      ),
    );
  }
}
