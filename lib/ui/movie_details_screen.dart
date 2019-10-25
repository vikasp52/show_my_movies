import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:show_my_movies/model/movie_model.dart';
import 'package:show_my_movies/util/const.dart';
import 'package:show_my_movies/widgets/movie_name_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;
  final PaletteGenerator palette;

  MovieDetailsScreen({this.movieModel, this.palette});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.network(
            'https://image.tmdb.org/t/p/w500${movieModel.posterPath}',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Container(
            color: palette.darkMutedColor == null?Colors.grey:palette.darkMutedColor.color.withOpacity(0.8),
          ),
          Positioned(
            top: size_60,
            right: size_20,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: size_40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: size_40, right: size_20, bottom: size_20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size_120,
                ),
                MovieNameWidget(
                  name: movieModel.title,
                  style: nameBigStyle.copyWith(color: palette.darkMutedColor == null?Colors.white:palette.lightMutedColor.color),
                ),
                SizedBox(height: size_16),
                Text(movieModel.release_date,
                    style: descriptionBoldStyle.copyWith(color: palette.darkMutedColor == null?Colors.grey:palette.lightMutedColor.color)),
                SizedBox(height: size_20),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(movieModel.overview, style: descriptionStyle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}