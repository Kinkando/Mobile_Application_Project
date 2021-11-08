import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/pages/anime/anime_schedule_page.dart';
import 'package:anime_list_project/pages/anime/anime_search_page.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  final String routeName, endPoint;
  final Map<String, dynamic>? query;
  const SelectPage({Key? key, required this.routeName, required this.endPoint, this.query}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  late Future<dynamic> _futureList;
  final List<List<dynamic>> _weekStyle = [
    ["Monday", Colors.yellow],
    ["Tuesday", Colors.pinkAccent],
    ["Wednesday", Colors.green],
    ["Thursday", Colors.deepOrangeAccent],
    ["Friday", Colors.lightBlueAccent],
    ["Saturday", Colors.purple],
    ["Sunday", Colors.red],
  ];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _futureList = fetchApi(
      widget.endPoint,
      query: widget.query,
      page: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _futureList,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          var list = snapshot.data;
          return ListView.builder(
            shrinkWrap: widget.endPoint.contains(AnimeSearchPage.endPoint),
            padding: const EdgeInsets.all(8.0),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              if(widget.endPoint == AnimeSchedulePage.endPoint) {
                return _buildScheduleCard(context, list[index], _weekStyle[index]);
              }
              return index == list.length-1 && widget.endPoint.contains('top')
              ? _buildTopRankingCard(context, list[index])
              : BuildCard(item: list[index], endPoint: widget.endPoint);
            },
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _futureList = fetchApi(
                        widget.endPoint,
                        query: widget.query,
                        page: _page,
                      );
                    });
                  },
                  child: const Text('Try again!'),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Column _buildTopRankingCard(BuildContext context, list) {
    return Column(
      children: [
        BuildCard(item: list, endPoint: widget.endPoint),
        Row(
          mainAxisAlignment: _page<2 ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _page>1 ? _page-- : _page++;
                    _futureList = fetchApi(
                      widget.endPoint,
                      query: widget.query,
                      page: _page,
                    );
                  });
                },
                child: Text(_page>1 ? 'Back' : 'Next', style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleCard(BuildContext context, List<Anime> item, List weekStyle) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: item.length,
      itemBuilder: (BuildContext context, int index) {
        return index != 0
        ? BuildCard(item: item[index], endPoint: widget.endPoint)
        : Column(
          children: [
            BuildTopicCard(
              topic: weekStyle[0],
              color: weekStyle[1],
              margin: const EdgeInsets.all(8.0),
            ),
            BuildCard(item: item[index], endPoint: widget.endPoint),
          ],
        );
      }
    );
  }
}
