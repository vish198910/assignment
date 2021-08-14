import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDialogBox extends StatefulWidget {
  const AddDialogBox({Key? key, required this.addImage}) : super(key: key);

  final addImage;
  @override
  _AddDialogBoxState createState() => _AddDialogBoxState();
}

class _AddDialogBoxState extends State<AddDialogBox> {
  TextEditingController movieNameController = new TextEditingController();
  TextEditingController directorNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

