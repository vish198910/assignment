import 'package:assignment/res/custom_colors.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          'assets/firebase_logo.png',
          height: 20,
        ),
        SizedBox(width: 8),
        Row(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: CustomColors.firebaseYellow,
                fontSize: 18,
              ),
            ),
            Text(
              'View',
              style: TextStyle(
                color: CustomColors.firebaseOrange,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
