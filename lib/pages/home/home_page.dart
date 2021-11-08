import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  static const title = 'Home Page';
  static const page = 0;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Uchu Risuto",
      page: 0,
      body: ListView(
        children: [
          for(int i=1;i<MainScaffold.pageList.length;i+=2)
            _buildCard(context, [MainScaffold.pageList[i], MainScaffold.pageList[i+1]]),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<Map> pageInfo) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Row(
        children: [
          for(int i=0;i<2;i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        pageInfo[i]['routeName'],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(pageInfo[i]['icon'], size: 80.0),
                          Text(
                            pageInfo[i]['title'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
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