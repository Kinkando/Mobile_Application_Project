import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final PageInfo pageDetail = pageList['home']!;
  final List<PageInfo> _pageIteration = [
    for(var key in pageList.keys)
      if(key != 'home' && key != 'detail_anime' && key != 'detail_manga')
        pageList[key]!,
  ];
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: pageDetail.title,
      page: pageDetail.page!,
      body: ListView(
        children: [
          for(int i=0;i<_pageIteration.length;i+=2)
              _buildCard(context, [_pageIteration[i], _pageIteration[i+1]]),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<PageInfo> pageDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Row(
        children: [
          for(int i=0;i<2;i++)
            Expanded(
              child: Card(
                color: MainScaffold.backgroundColor,
                margin: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(
                      context,
                      pageDetail[i].routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          pageDetail[i].icon,
                          size: 80.0,
                          color: MainScaffold.defaultColor,
                        ),
                        Text(
                          pageDetail[i].title,
                          style: Theme.of(context).textTheme.bodyText1,
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