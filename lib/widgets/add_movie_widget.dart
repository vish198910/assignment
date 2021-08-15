import 'package:assignment/constants/constants.dart';
import 'package:assignment/models/movie_model.dart';
import 'package:assignment/res/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMovieDialog extends StatefulWidget {
  NewMovieDialog(
      {Key? key,
      required this.movieNameController,
      required this.directorNameController,
      required this.pickImageFromGallery,
      required this.addMovie,
      required this.id,
      required this.imgString,
      required this.movies,
      required this.filename})
      : super(key: key);

  final TextEditingController movieNameController;
  final TextEditingController directorNameController;
  final Function pickImageFromGallery;
  final Function addMovie;
  String imgString;
  int id;
  List<Movie> movies;
  String filename;
  @override
  _NewMovieDialogState createState() => _NewMovieDialogState();
}

class _NewMovieDialogState extends State<NewMovieDialog> {
  @override
  Widget build(BuildContext context) {
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
              color: CustomColors.firebaseNavy,
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
                      controller: widget.movieNameController,
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
                      controller: widget.directorNameController,
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
                      color: CustomColors.firebaseAmber,
                      onPressed: () {
                        widget.pickImageFromGallery();
                      },
                      child: Text(
                        "Pick Image",
                      ),
                    ),
                    Text(
                      "${widget.filename}",
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                          color: CustomColors.firebaseOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            widget.addMovie(
                              widget.movieNameController.text,
                              widget.directorNameController.text,
                              "${DateTime.now().microsecond + DateTime.now().second + DateTime.now().minute + DateTime.now().hour}",
                            );
                            setState(() {
                              widget.movieNameController.text = "";
                              widget.directorNameController.text = "";
                              widget.filename = "";
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
}
