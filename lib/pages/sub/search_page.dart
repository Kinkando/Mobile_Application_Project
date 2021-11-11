import 'package:anime_list_project/pages/main/home_page.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  static bool check = false;
  final PageInfo pageDetail;
  const SearchPage({Key? key, required this.pageDetail}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _name = '';
  Future<dynamic>? _futureNameList;

  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  void _initial() {
    setState(() {
      if(SearchPage.check) {
        _futureNameList = null;
        _name = '';
        _controller.clear();
        SearchPage.check = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initial();
    return ListView(
      controller: _scrollController,
      children: [
        _nameSearch(),
        if(_name.isNotEmpty)
          _buildFutureBuilder(),
      ],
    );
  }

  Widget _nameSearch() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: TextField(
        onSubmitted: (text) => _nameSearchSubmit(text),
        controller: _controller,
        style: GoogleFonts.notoSans(
          color: HomePage.defaultColor,
        ),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.notoSans(
            color: HomePage.defaultColor,
          ),
          fillColor: HomePage.backgroundColor,
          filled: true,
          prefixIcon: const Icon(Icons.search, color: HomePage.defaultColor),
          border: const OutlineInputBorder(),
          hintText: 'Enter ${widget.pageDetail.endPoint!.substring(widget.pageDetail.endPoint!.indexOf('/')+1)} name',
        ),
      ),
    );
  }

  void _nameSearchSubmit(String text) {
    setState(() {
      _name = text;
      if(_name.isNotEmpty) {
        _futureNameList = fetchApi(
          widget.pageDetail.endPoint!,
          query: _name.isNotEmpty ? {'q': _name} : null,
        );
      }
    });
  }

  FutureBuilder<dynamic> _buildFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: _futureNameList,
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
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('Not Found'),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
