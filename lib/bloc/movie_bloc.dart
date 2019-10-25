import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:show_my_movies/model/movie_model.dart';

class MovieBloc {
  static const key = 'f95e150147279056fcf6713b780061ba';

  String baseURL = 'https://api.themoviedb.org/3/discover/movie?api_key=$key&page=';

  bool hasLoaded = true;
  List<MovieModel> moviesList = [];
  List<MovieModel> topMoviesList = [];

  final BehaviorSubject<List<MovieModel>> _movieListController = BehaviorSubject();
  Stream<List<MovieModel>> get movieListStream => _movieListController.stream;

  final BehaviorSubject<List<MovieModel>> _topMovieListController = BehaviorSubject();
  Stream<List<MovieModel>> get topMovieListStream => _topMovieListController.stream;

  //Method the get the Movie data
  Future getMovies({String pageNo = '1'}) async {
    var response = await http.get('$baseURL$pageNo');
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Number movies: ${jsonResponse['results'].length}.");
      int resultLength = jsonResponse['results'].length;
      for (int i = 0; i < resultLength; i++) {
        MovieModel movie = MovieModel.fromJson(jsonResponse['results'][i]);
        moviesList.add(movie);

        if (jsonResponse['results'][i]['popularity'] > 70.0) {
          print('Popularity: ${jsonResponse['results'][i]['popularity']}');
          topMoviesList.add(movie);
        }
      }
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }

    _movieListController.add(moviesList);
    _topMovieListController.add(topMoviesList);
  }

  void dispose() {
    _movieListController.close();
    _topMovieListController.close();
  }
}

MovieBloc movieBloc = MovieBloc();
