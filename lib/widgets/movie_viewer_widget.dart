import 'dart:typed_data';

import 'package:assignment/res/custom_colors.dart';
import 'package:flutter/material.dart';

class MovieViewer extends StatelessWidget {
  const MovieViewer({Key? key, required this.bytes}) : super(key: key);
  final Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            shadowColor: CustomColors.firebaseYellow,
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Hero(
              tag: "imgHero",
              child: Image.memory(
                bytes,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
