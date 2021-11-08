import 'package:flutter/material.dart';

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
      color: color.withOpacity(0.5),
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
              style: const TextStyle(
                color: Colors.black,
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
