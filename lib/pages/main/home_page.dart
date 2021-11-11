import 'package:anime_list_project/models/genre.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:anime_list_project/pages/sub/genre_page.dart';
import 'package:anime_list_project/pages/sub/search_page.dart';
import 'package:anime_list_project/pages/sub/select_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const routeName = '';
  static const Color focusColor = Colors.blue, defaultColor = Colors.white, backgroundColor = Colors.black;
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final _drawerScrollController = ScrollController();
  final _homeScrollController = ScrollController();
  Genre? _args;
  bool _repeat = false;
  late dynamic _body;
  late String _title;
  late int _page;
  final List<PageInfo> _pageIteration = [
    pageList['seasonal_anime']!,
    pageList['schedule_anime']!,
    pageList['top_anime']!,
    pageList['top_manga']!,
    pageList['genre_anime']!,
    pageList['genre_manga']!,
    pageList['search_anime']!,
    pageList['search_manga']!,
  ];

  @override
  void initState() {
    super.initState();
    _title = pageList['home']!.title;
    _page = pageList['home']!.page!;
    _body = ListView(
      controller: _homeScrollController,
      children: [
        for(int i=0;i<_pageIteration.length;i+=2)
          _buildNavigatorCard([_pageIteration[i], _pageIteration[i+1]]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    _argsSetting(args);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.headline1),
        backgroundColor: HomePage.backgroundColor,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: HomePage.backgroundColor,
        ),
        child: Drawer(
          child: ListView(
            controller: _drawerScrollController,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: HomePage.backgroundColor),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
              ),
              _buildTopicTile('Main Menu'),
              _buildListTile(context, pageList['home']!),
              _buildTopicTile('Anime'),
              for(var key in pageList.keys)
                if(key.contains('anime') && !key.contains('detail'))
                  _buildListTile(context, pageList[key]!),
              _buildTopicTile('Manga'),
              for(var key in pageList.keys)
                if(key.contains('manga') && !key.contains('detail'))
                  _buildListTile(context, pageList[key]!),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _body,
      ),
    );
  }

  Padding _buildTopicTile(String topic) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 16.0),
      child: Text(
        topic,
        style: GoogleFonts.notoSans(fontSize: 16.0, color: HomePage.defaultColor.withOpacity(0.5)),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, PageInfo pageDetail) {
    return ListTile(
      selectedTileColor: HomePage.focusColor,
      hoverColor: HomePage.focusColor,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              pageDetail.icon,
              color: HomePage.defaultColor,
            ),
          ),
          Text(
            pageDetail.title,
            style: GoogleFonts.notoSans(color: HomePage.defaultColor),
          ),
        ],
      ),
      onTap: () {
        if(_page != pageDetail.page) {
          _changeSubPage(pageDetail);
        }
        Navigator.pop(context);
      },
      selected: _page == pageDetail.page,
    );
  }

  void _argsSetting(args) {
    setState(() {
      if(args != null && !_repeat) {
        _args = args as Genre;
        Genre genre = args;
        PageInfo pageNavigator = genre.type == 'anime' ? pageList['genre_anime']! : pageList['genre_manga']!;
        _title = pageNavigator.title;
        _page = pageNavigator.page!;
        GenrePage.args = args;
        _body = GenrePage(pageDetail: pageNavigator);
        _repeat = true;
      }
    });
  }

  void _changeSubPage(PageInfo pageDetail) {
    setState(() {
      _title = pageDetail.title;
      _page = pageDetail.page!;
      if(pageDetail.routeName.contains('search')) {
        _args = null;
        SearchPage.check = true;
        _body = SearchPage(pageDetail: pageDetail);
      }
      else if(pageDetail.routeName.contains('genre')) {
        GenrePage.check = true;
        GenrePage.args = _args;
        _body = GenrePage(pageDetail: pageDetail);
      }
      else if(pageDetail.routeName.contains('home')){
        _args = null;
        _body = ListView(
          controller: _homeScrollController,
          children: [
            for(int i=0;i<_pageIteration.length;i+=2)
              _buildNavigatorCard([_pageIteration[i], _pageIteration[i+1]]),
          ],
        );
      }
      else {
        _args = null;
        SelectPage.check = true;
        _body = SelectPage(pageDetail: pageDetail);
      }
    });
  }

  Widget _buildNavigatorCard(List<PageInfo> pageDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Row(
        children: [
          for(int i=0;i<pageDetail.length;i++)
            Expanded(
              child: Card(
                color: HomePage.backgroundColor,
                margin: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: () => _changeSubPage(pageDetail[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          pageDetail[i].icon,
                          size: 80.0,
                          color: HomePage.defaultColor,
                        ),
                        Text(
                          pageDetail[i].title,
                          style: GoogleFonts.notoSans(fontSize: 14.0, color: HomePage.defaultColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
