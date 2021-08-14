import 'dart:typed_data';

import 'package:flutter/material.dart';

class MovieViewer extends StatelessWidget {
  const MovieViewer({Key? key, required this.bytes}) : super(key: key);
  final Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: "imgHero",
          child: Image.memory(
            bytes,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
