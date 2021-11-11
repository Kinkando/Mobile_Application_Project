import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/pages/home_page.dart';
import 'package:anime_list_project/pages/widgets/build_card.dart';
import 'package:anime_list_project/pages/widgets/build_topic_card.dart';
import 'package:anime_list_project/utils/fetch_future.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPage extends StatefulWidget {
  static bool check = false;
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
  final _futureScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _futureList = fetchApi(
      widget.pageDetail.endPoint!.contains('top')
          ? '${widget.pageDetail.endPoint!}/$_page'
          : widget.pageDetail.endPoint!,
    );
  }

  void _initial() {
    setState(() {
      if(SelectPage.check) {
        _page = 1;
        _futureList = fetchApi(
          widget.pageDetail.endPoint!.contains('top')
              ? '${widget.pageDetail.endPoint!}/$_page'
              : widget.pageDetail.endPoint!,
        );
        SelectPage.check = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _initial();
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
            shrinkWrap: widget.pageDetail.endPoint!.contains(pageList['search_anime']!.endPoint!),
            controller: _futureScrollController,
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
                  style: GoogleFonts.notoSans(color: HomePage.defaultColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _futureList = fetchApi(
                        widget.pageDetail.endPoint!.contains('top')
                            ? '${widget.pageDetail.endPoint!}/$_page'
                            : widget.pageDetail.endPoint!,
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: HomePage.backgroundColor,
                  ),
                  child: Text(
                    'Try again!',
                    style: GoogleFonts.notoSans(color: HomePage.defaultColor),
                  ),
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
                      widget.pageDetail.endPoint!.contains('top')
                          ? '${widget.pageDetail.endPoint!}/$_page'
                          : widget.pageDetail.endPoint!,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: HomePage.backgroundColor,
                ),
                child: Text(
                  _page>1 ? 'Back' : 'Next',
                  style: GoogleFonts.notoSans(color: HomePage.defaultColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleCard(BuildContext context, List<Anime> item, List weekStyle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BuildTopicCard(
            topic: weekStyle[0],
            color: weekStyle[1],
            margin: const EdgeInsets.all(8.0),
          ),
          for(int i=0;i<item.length;i++)
            BuildCard(item: item[i], endPoint: widget.pageDetail.endPoint!),
        ],
      ),
    );
  }
}
