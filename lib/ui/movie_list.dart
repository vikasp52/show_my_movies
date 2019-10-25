import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:show_my_movies/bloc/movie_bloc.dart';
import 'package:show_my_movies/model/movie_model.dart';
import 'package:show_my_movies/widgets/movie_card_widget.dart';
import 'package:show_my_movies/widgets/page_transation.dart';
import 'movie_details_screen.dart';


class Movies extends StatefulWidget {
  final List<MovieModel> movies;
  Movies(this.movies);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        movieBloc.getMovies(pageNo: "${currentPage++}");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<PaletteGenerator> _generatePalette(context, String imagePath) async {
    PaletteGenerator _paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(imagePath), size: Size(110, 150), maximumColorCount: 20);

    return _paletteGenerator;
  }

  static const Widget progress = Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));

  Widget movieCard() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: widget.movies.length + 1,
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              print('widget.movies.length: ${widget.movies.length}');
              print('index: $index');
              if (index == widget.movies.length) {
                print('Show progressbar');
                return progress;
              }

              return MovieCard(
                title: widget.movies[index].title,
                imageUrl: widget.movies[index].posterPath,
                onTap: () {
                  _generatePalette(context, 'https://image.tmdb.org/t/p/w500${widget.movies[index].backdrop_path}').then((_palette) {

                    Navigator.push(context, ScaleRoute(page: MovieDetailsScreen(movieModel: widget.movies[index], palette: _palette)));
                  });
                },
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return movieCard();
  }
}
