import 'dart:io';
import 'package:assignment/constants/constants.dart';
import 'package:assignment/database/dbhelper.dart';
import 'package:assignment/models/movie_model.dart';
import 'package:assignment/res/custom_colors.dart';
import 'package:assignment/screens/user_info_screen.dart';
import 'package:assignment/utilities/poster_utility.dart';
import 'package:assignment/widgets/add_movie_widget.dart';
import 'package:assignment/widgets/edit_movie_widget.dart';
import 'package:assignment/widgets/movie_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MoviesList extends StatefulWidget {
  //
  MoviesList({required this.user}) : super();

  final String title = "Movies";
  User user;
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  late Future<File> imageFile;
  late Image image;
  late DatabaseController databaseController;
  late List<Movie> movies;
  late String imgString;
  TextEditingController movieNameController = new TextEditingController();
  TextEditingController directorNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    movies = [];
    databaseController = DatabaseController();
    refreshImages();
  }

  //refresh gallery after CRUD operations
  refreshImages() {
    databaseController.getMovieList().then((imgs) {
      setState(() {
        movies.clear();
        movies.addAll(imgs);
      });
    });
  }

//Dialog box for adding images

  Widget newMovieBox(context) {
    return NewMovieDialog(
      movieNameController: movieNameController,
      directorNameController: directorNameController,
      addMovie: addMovie,
      id: movies.length + 1,
      imgString: '',
      pickImageFromGallery: pickImageFromGallery,
      movies: movies,
    );
  }

//Dialog box for editing images

  Widget editMovieBox(context, int id, String title, String director) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EditMovieDialog(
          movieNameController: movieNameController,
          directorNameController: directorNameController,
          pickImageFromGallery: pickImageFromGallery,
          editMovie: editMovie,
          id: id,
          imgString: imgString),
    );
  }

//pick image from gallery

  String pickImageFromGallery() {
    try {
      ImagePicker()
          .pickImage(source: ImageSource.gallery)
          .then((imgFile) async {
        imgString = Utility.base64String(await imgFile!.readAsBytes());
      });
    } catch (platformException) {
      print(platformException);
    }

    return imgString;
  }

  //Add Movie from Gallery
  addMovie(String title, String director, int id) {
    Movie movie =
        Movie(posterPath: imgString, title: title, director: director, id: id);
    databaseController.insertMovie(movie);
    refreshImages();
  }

  //Delete Movie from Gallery

  deleteMovieFromGallery(int id) {
    databaseController.deleteMovie(id);
    refreshImages();
  }

  //Edit Movie from Gallery

  editMovie(String title, String director, int id) {
    Movie movie =
        Movie(posterPath: imgString, title: title, director: director, id: id);
    databaseController.updateMovie(movie);
    refreshImages();
  }

  void updateMovie(
      int id, String title, String director, String posterPath) async {
    setState(() {
      movieNameController.text = title;
      directorNameController.text = director;
    });

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: editMovieBox(context, id, title, director),
          );
        });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: movies.length != 0
          ? ListView(
              children: movies.map((movie) {
                return MovieListTile(
                  context: context,
                  movie: movie,
                  editMovie: updateMovie,
                  deleteMovie: deleteMovieFromGallery,
                );
              }).toList(),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColors.firebaseOrange,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firebaseNavy,
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.padding),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: newMovieBox(context),
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return UserInfoScreen(
                      user: widget.user,
                    );
                  });
            },
          ),
        ],
      ),
      body: Container(
        color: CustomColors.firebaseYellow,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: gridView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
