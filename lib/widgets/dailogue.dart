import 'package:flutter/material.dart';

class Dailogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.blueAccent,
      behavior: SnackBarBehavior.floating,
    ));
  }
}