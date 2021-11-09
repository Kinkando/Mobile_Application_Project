import 'package:anime_list_project/models/genre.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final dynamic args;
  final String title, routeName, endPoint;
  final int page;
  const SearchPage({
    Key? key,
    required this.args,
    required this.title,
    required this.routeName,
    required this.endPoint,
    required this.page,
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

  @override
  void initState() {
    super.initState();
    _type = widget.routeName.contains('anime') ? 'anime' : 'manga';
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
      _futureGenreList = fetchApi('${widget.endPoint}/${_genre!.malId!}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: widget.title,
      initialPage: widget.args != null ? 1 : 0,
      tabs: _searchTab,
      page: widget.page,
      body: TabBarView(
        children: _searchTab.map((tab) {
          if(tab.text! == 'Genre') {
            return _genreSearch();
          }
          return _nameSearch();
        }).toList(),
      ),
    );
  }

  Widget _nameSearch() {
    return ListView(
      children: [
        Padding(
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
        ),
        if(_name.isNotEmpty)
          _buildFutureBuilder(),
      ],
    );
  }

  Widget _genreSearch() {
    if(widget.args != null && _genre == null) {
      _genreSearchSubmit(widget.args as Genre);
    }
    List<String> genreList = Genre.genreList(_type);
    return _genre == null ? _buildGenreTag(genreList) :
    ListView(
      children: [
        BuildTopicCard(
          color: Colors.black,
          topic: _genre!.name!,
          margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        ),
        _buildFutureBuilder(),
        _buildGenreTag(genreList),
      ],
    );
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
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return BuildCard(item: list[index], endPoint: widget.endPoint);
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
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
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

  Padding _buildGenreTag(List<String> genreList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Wrap(
            children: [
              for(int i=1;i<genreList.length;i++)
                if(genreList[i].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _genreSearchSubmit(Genre(malId: i, name: genreList[i], type: _type)),
                      style: ElevatedButton.styleFrom(primary: MainScaffold.backgroundColor),
                      child: Text(
                        genreList[i],
                        style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
                      ),
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
