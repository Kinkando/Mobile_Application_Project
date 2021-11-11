import 'package:anime_list_project/models/genre.dart';
import 'package:anime_list_project/pages/home_page.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenrePage extends StatefulWidget {
  static bool check = false;
  static dynamic args;
  final PageInfo pageDetail;

  const GenrePage({Key? key, required this.pageDetail}) : super(key: key);

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  Genre? _genre;
  Future<dynamic>? _futureGenreList;
  final _scrollController = ScrollController();

  void _initial() {
    setState(() {
      if (GenrePage.check) {
        _futureGenreList = null;
        _genre = null;
        GenrePage.args = null;
        GenrePage.check = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _initial();
    return ListView(
      controller: _scrollController,
      children: _genreSearch(),
    );
  }

  List<Widget> _genreSearch() {
    if (GenrePage.args != null && _genre == null) {
      _genreSearchSubmit(GenrePage.args as Genre);
    }
    List<Genre> genreList = Genre.genreList(widget.pageDetail.endPoint!.contains('manga') ? 'manga' : 'anime');
    return _genre == null
    ? [_buildGenreTag(genreList)]
    : [
    BuildTopicCard(
    color: Colors.black,
    topic: _genre!.name,
    margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
    ),
    _buildFutureBuilder(),
    _buildGenreTag(genreList),
    ];
    }

  void _genreSearchSubmit(Genre genre) {
    setState(() {
      _genre = genre;
      _futureGenreList = fetchApi('${widget.pageDetail.endPoint}/${_genre!.malId}');
    });
  }

  FutureBuilder<dynamic> _buildFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: _futureGenreList,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          var list = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  for(int i=0;i<list.length;i++)
                    BuildCard(item: list[i], endPoint: widget.pageDetail.endPoint!),
                ]
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.notoSans(
                        color: HomePage.defaultColor),
                  ),
                  ElevatedButton(
                    onPressed: () => _genreSearchSubmit(_genre!),
                    style: ElevatedButton.styleFrom(
                      primary: HomePage.backgroundColor,
                    ),
                    child: Text(
                      'Try again!',
                      style: GoogleFonts.notoSans(
                          color: HomePage.defaultColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Padding _buildGenreTag(List<Genre> genreList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          for (int i = 0; i < genreList.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: ElevatedButton(
                onPressed: () => _genreSearchSubmit(genreList[i]),
                style: ElevatedButton.styleFrom(
                    primary: HomePage.backgroundColor),
                child: Text(
                  genreList[i].name,
                  style: GoogleFonts.notoSans(color: HomePage.defaultColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
