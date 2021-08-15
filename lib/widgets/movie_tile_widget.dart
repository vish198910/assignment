import 'dart:convert';

import 'package:assignment/database/dbhelper.dart';
import 'package:assignment/models/movie_model.dart';
import 'package:assignment/res/custom_colors.dart';
import 'package:assignment/utilities/poster_utility.dart';
import 'package:assignment/widgets/movie_viewer_widget.dart';
import 'package:flutter/material.dart';

class MovieListTile extends StatefulWidget {
  const MovieListTile({
    Key? key,
    required this.context,
    required this.movie,
    required this.deleteMovie,
    required this.editMovie,
  }) : super(key: key);

  final BuildContext context;
  final Movie movie;
  final Function editMovie;
  final Function deleteMovie;
  @override
  _MovieListTileState createState() => _MovieListTileState();
}

class _MovieListTileState extends State<MovieListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.firebaseNavy,
      elevation: 5.0,
      shadowColor: CustomColors.firebaseNavy,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MovieViewer(
                  bytes: base64Decode(
                    widget.movie.posterPath,
                  ),
                );
              }));
            },
            child: Hero(
                tag: "imageHero",
                child: Utility.imageFromBase64String(widget.movie.posterPath)),
          ),
          title: Text(
            widget.movie.title.toUpperCase(),
          ),
          subtitle: Text(
            widget.movie.director.toUpperCase(),
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.editMovie(
                      widget.movie.id,
                      widget.movie.title,
                      widget.movie.director,
                      widget.movie.posterPath,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Icon(
                      Icons.edit,
                      color: CustomColors.firebaseYellow,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.deleteMovie(widget.movie.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Icon(
                      Icons.delete,
                      color: CustomColors.firebaseAmber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
