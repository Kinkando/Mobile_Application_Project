class Genre {
  int malId;
  String type, name;

  Genre ({
    required this.malId,
    required this.type,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'],
      type: json['type'],
      name: json['name'],
    );
  }

  static List<Genre> genreList(String type) {
    List<Genre> genreList = [
      Genre(malId: 1, type: type, name: 'Action'),
      Genre(malId: 2, type: type, name: 'Adventure'),
      Genre(malId: 3, type: type, name: 'Cars'),
      Genre(malId: 4, type: type, name: 'Comedy'),
      Genre(malId: 5, type: type, name: 'Avante Garde'),
      Genre(malId: 6, type: type, name: 'Demons'),
      Genre(malId: 7, type: type, name: 'Mystery'),
      Genre(malId: 8, type: type, name: 'Drama'),
      Genre(malId: 9, type: type, name: 'Ecchi'),
      Genre(malId: 10, type: type, name: 'Fantasy'),
      Genre(malId: 11, type: type, name: 'Game'),
      Genre(malId: 12, type: type, name: 'Hentai'),
      Genre(malId: 13, type: type, name: 'Historical'),
      Genre(malId: 14, type: type, name: 'Horror'),
      Genre(malId: 15, type: type, name: 'Kids'),
      Genre(malId: 17, type: type, name: 'Martial Arts'),
      Genre(malId: 18, type: type, name: 'Mecha'),
      Genre(malId: 19, type: type, name: 'Music'),
      Genre(malId: 20, type: type, name: 'Parody'),
      Genre(malId: 21, type: type, name: 'Samurai'),
      Genre(malId: 22, type: type, name: 'Romance'),
      Genre(malId: 23, type: type, name: 'School'),
      Genre(malId: 24, type: type, name: 'Sci Fi'),
      Genre(malId: 25, type: type, name: 'Shoujo'),
      Genre(malId: 26, type: type, name: 'Girls Love'),
      Genre(malId: 27, type: type, name: 'Shounen'),
      Genre(malId: 28, type: type, name: 'Boys Love'),
      Genre(malId: 29, type: type, name: 'Space'),
      Genre(malId: 30, type: type, name: 'Sports'),
      Genre(malId: 31, type: type, name: 'Super Power'),
      Genre(malId: 32, type: type, name: 'Vampire'),
      Genre(malId: 35, type: type, name: 'Harem'),
      Genre(malId: 36, type: type, name: 'Slice Of Life'),
      Genre(malId: 37, type: type, name: 'Supernatural'),
      Genre(malId: 38, type: type, name: 'Military'),
      Genre(malId: 39, type: type, name: 'Police'),
      Genre(malId: 40, type: type, name: 'Psychological'),
    ];

    if(type == 'anime') {
      genreList.addAll([
        Genre(malId: 41, type: type, name: 'Suspense'),
        Genre(malId: 42, type: type, name: 'Seinen'),
        Genre(malId: 43, type: type, name: 'Josei'),
        Genre(malId: 46, type: type, name: 'Award Winning'),
        Genre(malId: 47, type: type, name: 'Gourmet'),
        Genre(malId: 48, type: type, name: 'Work Life'),
        Genre(malId: 49, type: type, name: 'Erotica'),
      ]);
    }
    else {
      genreList.addAll([
        Genre(malId: 41, type: type, name: 'Seinen'),
        Genre(malId: 42, type: type, name: 'Josei'),
        Genre(malId: 43, type: type, name: 'Doujinshi'),
        Genre(malId: 44, type: type, name: 'Gender Bender'),
        Genre(malId: 45, type: type, name: 'Suspense'),
        Genre(malId: 46, type: type, name: 'Award Winning'),
        Genre(malId: 47, type: type, name: 'Gourmet'),
        Genre(malId: 49, type: type, name: 'Erotica'),
      ]);
    }
    genreList.sort((a, b) => a.name.compareTo(b.name));
    return genreList;
  }

  @override
  String toString() {
    return '$malId $name ($type)';
  }
}