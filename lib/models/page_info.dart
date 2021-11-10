import 'package:flutter/material.dart';

class PageInfo {
  final String title, routeName;
  final String? endPoint;
  final int? page;
  final IconData? icon;

  PageInfo({
    required this.title,
    required this.routeName,
    this.page,
    this.icon,
    this.endPoint,
  });
}

final Map<String, PageInfo> pageList = {
  'home': PageInfo(title: 'Home Page', routeName: '/home', page: 0, icon: Icons.home),
  'seasonal_anime': PageInfo(title: 'Seasonal Anime', routeName: '/anime/season', page: 1, endPoint: 'season', icon: Icons.cloud),
  'schedule_anime': PageInfo(title: 'Schedule Anime', routeName: '/anime/schedule', page: 2, endPoint: 'schedule', icon: Icons.date_range),
  'top_anime': PageInfo(title: 'Top Anime', routeName: '/anime/top', page: 3, endPoint: 'top/anime', icon: Icons.whatshot),
  'search_anime': PageInfo(title: 'Search Anime', routeName: '/anime/search', page: 4, endPoint: 'genre/anime', icon: Icons.search),
  'top_manga': PageInfo(title: 'Top Manga', routeName: '/manga/top', page: 5, endPoint: 'top/manga', icon: Icons.whatshot),
  'search_manga': PageInfo(title: 'Search Manga', routeName: '/manga/search', page: 6, endPoint: 'genre/manga', icon: Icons.search),
  'detail_anime': PageInfo(title: 'Anime Detail', routeName: '/anime/detail'),
  'detail_manga': PageInfo(title: 'Manga Detail', routeName: '/manga/detail'),
};