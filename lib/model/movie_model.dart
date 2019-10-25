import 'package:meta/meta.dart';

class MovieModel {
  MovieModel({
    @required this.id,
    @required this.overview,
    @required this.title,
    @required this.posterPath,
    @required this.release_date,
    @required this.backdrop_path,
  });

  String title, posterPath, id, overview, release_date, backdrop_path;
  //double vote_average;

  MovieModel.fromJson(Map json)
      : title = json["title"],
        posterPath = json["poster_path"],
        id = json["id"].toString(),
        overview = json["overview"],
        release_date = json["release_date"],
        backdrop_path = json["backdrop_path"];
  //vote_average = json["vote_average"];
}
