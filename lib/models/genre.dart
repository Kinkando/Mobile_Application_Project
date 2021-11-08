class Genre {
  int? malId;
  String? type, name;

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

  static List<String> genreList(String type) {
    List<String> genreList = [
      '',
      'Action',
      'Adventure',
      'Cars',
      'Comedy',
      'Avante Garde',
      'Demons',
      'Mystery',
      'Drama',
      'Ecchi',
      'Fantasy',
      'Game',
      'Hentai',
      'Historical',
      'Horror',
      'Kids',
      '',
      'Martial Arts',
      'Mecha',
      'Music',
      'Parody',
      'Samurai',
      'Romance',
      'School',
      'Sci Fi',
      'Shoujo',
      'Girls Love',
      'Shounen',
      'Boys Love',
      'Space',
      'Sports',
      'Super Power',
      'Vampire',
      '',
      '',
      'Harem',
      'Slice Of Life',
      'Supernatural',
      'Military',
      'Police',
      'Psychological',
    ];

    if(type == 'Anime') {
      genreList.addAll([
        'Suspense',
        'Seinen',
        'Josei',
        '',
        ''
      ]);
    }
    else {
      genreList.addAll([
        'Seinen',
        'Josei',
        'Doujinshi',
        'Gender Bender',
        'Suspense'
      ]);
    }

    genreList.addAll([
      'Award Winning',
      'Gourmet',
      'Work Life',
      'Erotica',
    ]);

    return genreList;
  }

  @override
  String toString() {
    return '${name!} ${type!}';
  }
}