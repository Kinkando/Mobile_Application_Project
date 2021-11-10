import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int page, initialPage;
  final List<Tab>? tabs;
  static const Color focusColor = Colors.blue, defaultColor = Colors.white, backgroundColor = Colors.black;

  const MainScaffold({
    Key? key,
    required this.title,
    required this.page,
    required this.body,
    this.tabs,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialPage,
      length: tabs!=null ? tabs!.length : 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: Theme.of(context).textTheme.headline1),
          bottom: tabs==null ? null : TabBar(tabs: tabs!),
          backgroundColor: backgroundColor,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: backgroundColor,
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: backgroundColor),
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
          child: body,
        ),
      ),
    );
  }

  Padding _buildTopicTile(String topic) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0),
      child: Text(
        topic,
        style: GoogleFonts.notoSans(fontSize: 16.0, color: defaultColor.withOpacity(0.5)),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, PageInfo pageDetail) {
    return ListTile(
      selectedTileColor: MainScaffold.focusColor,
      hoverColor: MainScaffold.focusColor,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              pageDetail.icon,
              color: defaultColor,
            ),
          ),
          Text(
            pageDetail.title,
            style: GoogleFonts.notoSans(color: defaultColor),
          ),
        ],
      ),
      onTap: () {
        if(page != pageDetail.page) {
          Navigator.pushReplacementNamed(
            context,
            pageDetail.routeName,
          );
        }
        else {
          Navigator.pop(context);
        }
      },
      selected: page == pageDetail.page,
    );
  }
}
