// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ExercisesTitle extends StatelessWidget {
  final String TextTitle;
  final int numberSubtitle;
  final icon;
  final color;
  const ExercisesTitle({
    super.key,
    required this.TextTitle,
    required this.numberSubtitle,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(2),
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/foodlaos2.png',
                    width: 50,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    TextTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    numberSubtitle.toString() + 'ລາຍການ',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          Icon(Icons.more_horiz),
        ],
      ),
    );
  }
}
