import 'package:assignment/constants/constants.dart';
import 'package:assignment/res/custom_colors.dart';
import 'package:flutter/material.dart';

class EditMovieDialog extends StatefulWidget {
  EditMovieDialog({
    Key? key,
    required this.movieNameController,
    required this.directorNameController,
    required this.pickImageFromGallery,
    required this.editMovie,
    required this.imgString,
    required this.id,
    required this.filename,
  }) : super(key: key);

  final TextEditingController movieNameController;
  final TextEditingController directorNameController;
  final Function pickImageFromGallery;
  final Function editMovie;
  String imgString;
  String id;
  String filename;
  @override
  _EditMovieDialogState createState() => _EditMovieDialogState();
}

class _EditMovieDialogState extends State<EditMovieDialog> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => Container(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.padding),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Stack(
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
                          borderRadius:
                              BorderRadius.circular(Constants.padding),
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
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
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
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
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
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPressed: () {
                                        widget.editMovie(
                                            widget.movieNameController.text,
                                            widget.directorNameController.text,
                                            widget.id);
                                        setState(() {
                                          widget.movieNameController.text = "";
                                          widget.directorNameController.text =
                                              "";
                                          widget.imgString = "";
                                          widget.filename = "";
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
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constants.avatarRadius)),
                          child: Icon(
                            Icons.movie,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
