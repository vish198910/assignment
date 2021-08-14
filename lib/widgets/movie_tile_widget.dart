import 'package:assignment/models/movie_model.dart';
import 'package:assignment/utilities/poster_utility.dart';
import 'package:flutter/material.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({Key? key, required this.context, required this.movie})
      : super(key: key);

  final BuildContext context;
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: Utility.imageFromBase64String(movie.posterPath),
          title: Text(
            movie.title.toUpperCase(),
          ),
          subtitle: Text(
            movie.director.toUpperCase(),
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Icon(
                    Icons.edit,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Icon(
                    Icons.delete,
                    color: Colors.deepPurpleAccent,
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
