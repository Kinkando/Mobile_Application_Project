import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/models/manga.dart';
import 'package:anime_list_project/pages/main/home_page.dart';
import 'package:anime_list_project/models/page_info.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final dynamic item;
  final String endPoint;
  const BuildCard({
    Key? key,
    required this.item,
    required this.endPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "", content1 = "", content2 = "", route = "", image = "";
    var material = item;
    if(item is Anime) {
      material = material as Anime;
      title = material.title!;
      image = material.imageUrl!;
      content1 = material.score != null && endPoint != pageList['top_anime']!.endPoint
          ? 'Score: ${material.score!}'
          : material.score == null && endPoint != pageList['top_anime']!.endPoint
            ? 'Score: -'
            : 'Rank: ${material.rank!}';
      content2 = material.source != null
          ? 'Source: ${material.source!}'
          : endPoint.contains('top')
            ? 'Score: ${material.score!}'
            : 'Episode: ${material.episodes!}';
      route = pageList['detail_anime']!.routeName;
    }
    else {
      material = material as Manga;
      title = material.title!;
      image = material.imageUrl!;
      content1 = endPoint.contains('top')
          ? 'Score: ${material.score!}'
          : material.volumes == null
          ? 'Volume: -'
          : 'Volume: ${material.volumes!}';
      content2 = endPoint.contains('top')
          ? 'Rank: ${material.rank!}'
          : 'Publishing Start: ${material.publishingStart}';
      route = pageList['detail_manga']!.routeName;
    }
    return Card(
      color: HomePage.backgroundColor.withOpacity(0.5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            route,
            arguments: material,
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                image,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(right: 13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, bottom: 14.0,),
                            child: Text(
                              content1,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          Text(
                            content2,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
