import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/pages/widgets/main_scaffold.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPage extends StatefulWidget {
  final PageInfo pageDetail;
  const SelectPage({Key? key, required this.pageDetail}) : super(key: key);

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
      widget.pageDetail.endPoint!,
      page: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: widget.pageDetail.title,
      page: widget.pageDetail.page!,
      body: FutureBuilder<dynamic>(
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
              shrinkWrap: widget.pageDetail.endPoint!.contains(pageList['search_anime']!.endPoint!),
              padding: const EdgeInsets.all(8.0),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                if(widget.pageDetail.endPoint == pageList['schedule_anime']!.endPoint) {
                  return _buildScheduleCard(context, list[index], _weekStyle[index]);
                }
                return index == list.length-1 && widget.pageDetail.endPoint!.contains('top')
                ? _buildTopRankingCard(context, list[index])
                : BuildCard(item: list[index], endPoint: widget.pageDetail.endPoint!);
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureList = fetchApi(
                          widget.pageDetail.endPoint!,
                          page: _page,
                        );
                      });
                    },
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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Column _buildTopRankingCard(BuildContext context, list) {
    return Column(
      children: [
        BuildCard(item: list, endPoint: widget.pageDetail.endPoint!),
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
                      widget.pageDetail.endPoint!,
                      page: _page,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: MainScaffold.backgroundColor,
                ),
                child: Text(
                  _page>1 ? 'Back' : 'Next',
                  style: GoogleFonts.notoSans(color: MainScaffold.defaultColor),
                ),
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
        ? BuildCard(item: item[index], endPoint: widget.pageDetail.endPoint!)
        : Column(
          children: [
            BuildTopicCard(
              topic: weekStyle[0],
              color: weekStyle[1],
              margin: const EdgeInsets.all(8.0),
            ),
            BuildCard(item: item[index], endPoint: widget.pageDetail.endPoint!),
          ],
        );
      }
    );
  }
}
