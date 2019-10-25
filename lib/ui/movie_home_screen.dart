import 'package:flutter/material.dart';
import 'package:show_my_movies/bloc/movie_bloc.dart';
import 'package:show_my_movies/model/movie_model.dart';
import 'movie_list.dart';

class MovieHomeScreen extends StatefulWidget {
  @override
  _MovieHomeScreenState createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  Widget tab({String tabName}) {
    return Tab(
      child: Text(tabName),
    );
  }

  @override
  void initState() {
    super.initState();
    movieBloc.getMovies();
  }

  Widget nowPlayingTab() {
    return StreamBuilder<List<MovieModel>>(
        stream: movieBloc.movieListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: progress,
            );
          }
          return Movies(snapshot.data);
        });
  }

  Widget topBoxOfficeTab() {
    return StreamBuilder<List<MovieModel>>(
        stream: movieBloc.topMovieListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Movies(snapshot.data);
          }
          return SizedBox();
        });
  }

  Widget anticipatedTab() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            child: Icon(
              Icons.error,
              size: 70.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.black12,
            radius: 70.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'SOMETHING AWESONE IS IN THE WORK',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static const Widget progress =
      Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SHOW MY MOVIES',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
          bottom: PreferredSize(
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.white),
                indicatorColor: Colors.black,
                tabs: [
                  tab(tabName: 'NOW PLAYING'),
                  tab(tabName: 'TOP BOX OFFICE'),
                  tab(tabName: 'ANTICIPATED'),
                  tab(tabName: 'UPCOMMING'),
                ]),
            preferredSize: Size.fromHeight(50.0),
          ),
        ),
        body: TabBarView(children: <Widget>[nowPlayingTab(), topBoxOfficeTab(), anticipatedTab(), anticipatedTab()]),
      ),
    );
  }
}
