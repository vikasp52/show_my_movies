import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {

  final String title;
  final String imageUrl;
  final GestureTapCallback onTap;


  MovieCard({this.title, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {

    GestureDetector _buildTopicCard() {
      return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network('https://image.tmdb.org/t/p/w92/$imageUrl', fit: BoxFit.fill, ),
              Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }


    return _buildTopicCard();
  }
}
