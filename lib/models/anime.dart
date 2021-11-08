import 'package:anime_list_project/models/genre.dart';

class Anime {
  final int? malId, episodes, rank;
  final double? score;
  final bool? airing;
  final String? title, type, imageUrl, source, synopsis, airingStart, startDate, endDate;
  final List<Genre>? genres;

  Anime({
    required this.malId,
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.type,
    required this.airing,
    required this.airingStart,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.episodes,
    required this.genres,
    required this.source,
    required this.score,
  });

  factory Anime.fromMap(Map<String, dynamic> json) {
    return Anime(
      malId: json.containsKey('mal_id') ? json['mal_id'] : null,
      rank: json.containsKey('rank') ? json['rank'] : null,
      title: json.containsKey('title') ? json['title'] : null,
      imageUrl: json.containsKey('image_url') ? json['image_url'] : null,
      synopsis: json.containsKey('synopsis') ? json['synopsis'] : null,
      type: json.containsKey('type') ? json['type'] : null,
      airing: json.containsKey('airing') ? json['airing'] : null,
      airingStart: json.containsKey('airing_start') ? json['airing_start'] : null,
      startDate: json.containsKey('start_date') ? json['start_date'] : null,
      endDate: json.containsKey('end_date') ? json['end_date'] : null,
      episodes: json.containsKey('episodes') ? json['episodes'] : null,
      genres: json.containsKey('genres') ? (json['genres'] as List).map((genre) => Genre.fromMap(genre)).toList() : null,
      source: json.containsKey('source') ? json['source'] : null,
      score: json.containsKey('score') ? json['score'] : null,
    );
  }

  @override
  String toString() {
    return 'Anime: ${title!}';
  }
}