import 'dart:io';
import 'package:assignment/constants/constants.dart';
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

  refreshImages() {
    databaseController.getMovieList().then((imgs) {
      setState(() {
        movies.clear();
        movies.addAll(imgs);
      });
    });
  }

//Dialog box for adding images

  Widget contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: movieNameController,
                      decoration: InputDecoration(
                          hintText: "Movie Name",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: directorNameController,
                      decoration: InputDecoration(
                          hintText: "Director Name",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.white,
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      child: Text(
                        "Pick Image",
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            addMovie(
                              movieNameController.text,
                              directorNameController.text,
                              movies.length + 1,
                            );
                            setState(() {
                              movieNameController.text = "";
                              directorNameController.text = "";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Add Movie",
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Icon(
                Icons.movie,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget editMovieBox(context, int id, String title, String director) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: movieNameController,
                      decoration: InputDecoration(
                          hintText: "Movie Name",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: directorNameController,
                      decoration: InputDecoration(
                          hintText: "Director Name",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.white,
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      child: Text(
                        "Pick Image",
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            editMovie(movieNameController.text,
                                directorNameController.text, id);
                            setState(() {
                              movieNameController.text = "";
                              directorNameController.text = "";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Edit Movie",
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Icon(
                Icons.movie,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String pickImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      imgString = Utility.base64String(await imgFile!.readAsBytes());
    });
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

  deleteMovie(int id) {
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

  void updateMovie(int id, String title, String director) async {
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
      child: ListView(
        children: movies.map((movie) {
          return MovieListTile(
            context: context,
            movie: movie,
            editMovie: updateMovie,
            deleteMovie: deleteMovie,
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
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.padding),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: contentBox(context),
                    );
                  });
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
