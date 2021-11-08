import 'package:anime_list_project/models/genre.dart';

class Manga {
  final int? malId, rank, volumes;
  final double? score;
  final String? title, imageUrl, type, startDate, endDate, synopsis, publishingStart;
  final List<Genre>? genres;

  Manga({
    required this.malId,
    required this.rank,
    required this.volumes,
    required this.score,
    required this.title,
    required this.imageUrl,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.publishingStart,
    required this.genres,
  });

  factory Manga.fromMap(Map<String, dynamic> json) {
    return Manga(
      malId: json.containsKey('mal_id') ? json['mal_id'] : null,
      rank: json.containsKey('rank') ? json['rank'] : null,
      volumes: json.containsKey('volumes') ? json['volumes'] : null,
      score: json.containsKey('score') ? json['score'] : null,
      title: json.containsKey('title') ? json['title'] : null,
      imageUrl: json.containsKey('image_url') ? json['image_url'] : null,
      type: json.containsKey('type') ? json['type'] : null,
      startDate: json.containsKey('start_date') ? json['start_date'] : null,
      endDate: json.containsKey('end_date') ? json['end_date'] : null,
      synopsis: json.containsKey('synopsis') ? json['synopsis'] : null,
      publishingStart: json.containsKey('publishing_start') ? json['publishing_start'] : null,
      genres: json.containsKey('genres') ? (json['genres'] as List).map((genre) => Genre.fromMap(genre)).toList() : null,
    );
  }

  @override
  String toString() {
    return 'Manga: ${title!}';
  }
}