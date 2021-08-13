import 'package:assignment/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, required this.movieModel}) : super(key: key);

  final Movie movieModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.asset(movieModel.posterPath),
        title: Text(movieModel.title),
        subtitle: Text(movieModel.director),
        trailing: Row(
          children: [Icon(Icons.delete), Icon(Icons.edit)],
        ),
      ),
    );
  }
}
