import 'package:anime_list_project/models/genre.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final PageInfo pageDetail;
  const SearchPage({
    Key? key,
    required this.pageDetail,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Tab> _searchTab = <Tab>[
    const Tab(text: 'Name'),
    const Tab(text: 'Genre'),
  ];

  late String _type;
  Genre? _genre;
  String _name = '', _mode = '';
  Future<dynamic>? _futureNameList, _futureGenreList;

  final _controller = TextEditingController();
  final _genreTagScrollController = ScrollController();
  final _futureScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _type = widget.pageDetail.endPoint!.contains('manga') ? 'manga' : 'anime';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nameSearchSubmit(String text) {
    setState(() {
      _mode = 'name';
      _name = text;
      if(_name.isNotEmpty) {
        _futureNameList = fetchApi(
          'search/$_type',
          query: _name.isNotEmpty ? {'q': _name} : null,
        );
      }
    });
  }

  void _genreSearchSubmit(Genre genre) {
    setState(() {
      _mode = 'genre';
      _genre = genre;
      _futureGenreList = fetchApi('${widget.pageDetail.endPoint}/${_genre!.malId}');
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    return MainScaffold(
      title: widget.pageDetail.title,
      initialPage: args != null ? 1 : 0,
      tabs: _searchTab,
      page: widget.pageDetail.page!,
      body: TabBarView(
        children: _searchTab.map((tab) {
          List<Widget> widget = [];
          if(tab.text! == 'Genre') {
            widget = _genreSearch(args);
          }
          else {
            widget.add(_nameSearch());
            if(_name.isNotEmpty) {
              widget.add(_buildFutureBuilder());
            }
          }
          return ListView(
            controller: _genreTagScrollController,
            children: widget,
          );
        }).toList(),
      ),
    );
  }

  Widget _nameSearch() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: TextField(
        onSubmitted: (text) => _nameSearchSubmit(text),
        controller: _controller,
        style: GoogleFonts.notoSans(
          color: MainScaffold.defaultColor,
        ),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.notoSans(
            color: MainScaffold.defaultColor,
          ),
          fillColor: MainScaffold.backgroundColor,
          filled: true,
          prefixIcon: const Icon(Icons.search, color: MainScaffold.defaultColor),
          border: const OutlineInputBorder(),
          hintText: 'Enter $_type name',
        ),
      ),
    );
  }

  List<Widget> _genreSearch(args) {
    if(args != null && _genre == null) {
      _genreSearchSubmit(args as Genre);
    }
    List<Genre> genreList = Genre.genreList(_type);
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

  FutureBuilder<dynamic> _buildFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: _mode == 'name' ? _futureNameList : _futureGenreList,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          var list = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            controller: _futureScrollController,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return BuildCard(item: list[index], endPoint: widget.pageDetail.endPoint!);
            },
          );
        }

        if (snapshot.hasError) {
          return _mode == 'name'
              ? const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('Not Found'),
            ),
          )
              : Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
                  ),
                  ElevatedButton(
                    onPressed: () => _genreSearchSubmit(_genre!),
                    style: ElevatedButton.styleFrom(
                      primary: MainScaffold.backgroundColor,
                    ),
                    child: Text(
                      'Try again!',
                      style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
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
          for(int i=0;i<genreList.length;i++)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: ElevatedButton(
                onPressed: () => _genreSearchSubmit(genreList[i]),
                style: ElevatedButton.styleFrom(primary: MainScaffold.backgroundColor),
                child: Text(
                  genreList[i].name,
                  style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
