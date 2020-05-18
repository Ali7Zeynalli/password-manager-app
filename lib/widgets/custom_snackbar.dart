import 'package:flutter/material.dart';

class CustomSnackBar {
  static void display({
    @required String text,
    @required BuildContext context,
  }) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Quicksand",
            color: Colors.white,
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}
