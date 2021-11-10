import 'package:anime_list_project/models/anime.dart';
import 'package:anime_list_project/models/manga.dart';
import 'package:anime_list_project/services/api.dart';

Future<dynamic> fetchApi(
  String endPoint, {
  Map<String, dynamic>? query,
}) async {
  final List list = await Api().fetch(endPoint, queryParams: query);
  if (!endPoint.contains('manga')) {
    if (endPoint == 'schedule') {
      List<List<Anime>> scheduleList = [];
      for (var element in list) {
        List<Anime> animeList = [];
        element.forEach((item) => animeList.add(Anime.fromMap(item)));
        scheduleList.add(animeList);
      }
      return scheduleList;
    }
    return list.map((item) => Anime.fromMap(item)).toList();
  }
  return list.map((item) => Manga.fromMap(item)).toList();
}
