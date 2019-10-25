import 'package:flutter/material.dart';

class MovieNameWidget extends StatelessWidget {

  final String name;
  final TextStyle style;

  MovieNameWidget({this.name, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(name.toUpperCase(), style: style);
  }
}