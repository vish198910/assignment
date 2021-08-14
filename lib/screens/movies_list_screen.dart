import 'dart:io';
import 'package:assignment/database/dbhelper.dart';
import 'package:assignment/models/movie_model.dart';
import 'package:assignment/utilities/poster_utility.dart';
import 'package:assignment/widgets/movie_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MoviesList extends StatefulWidget {
  //
  MoviesList() : super();

  final String title = "Movies";

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  late Future<File> imageFile;
  late Image image;
  late DatabaseController databaseController;
  late List<Movie> movies;

  TextEditingController movieNameController = new TextEditingController();
  TextEditingController directorNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    movies = [];
    databaseController = DatabaseController();
    refreshImages();
  }

  refreshImages() {
    databaseController.getMovieList().then((imgs) {
      setState(() {
        movies.clear();
        movies.addAll(imgs);
      });
    });
  }

  pickImageFromGallery(String title, String director, int id) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      String imgString = Utility.base64String(await imgFile!.readAsBytes());
      Movie movie = Movie(
          posterPath: imgString, title: title, director: director, id: id);
      databaseController.insertMovie(movie);
      refreshImages();
    });
  }

  deleteMovieFromGallery() {}


  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: ListView(
        children: movies.map((movie) {
          return MovieListTile(
            context: context,
            movie: movie,
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              pickImageFromGallery("demo", "Demo Director", movies.length + 1);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
    );
  }
}
