import 'package:flutter/material.dart';
import 'package:show_my_movies/ui/movie_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowMyMovies App',
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: MovieHomeScreen(),
    );
  }
}