import 'package:anime_list_project/pages/main/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTopicCard extends StatelessWidget {
  final Color color;
  final String topic;
  final EdgeInsets margin;
  const BuildTopicCard({
    Key? key,
    required this.color,
    required this.topic,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              topic,
              style: GoogleFonts.notoSans(
                color: color == HomePage.backgroundColor ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
