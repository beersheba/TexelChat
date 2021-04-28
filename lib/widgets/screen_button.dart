import 'package:flutter/material.dart';

class ScreenButton extends StatelessWidget {
  ScreenButton({this.title, this.color, this.onPressed});

  final String title;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        textColor: Colors.white,
        child: Text(
          title != null ? title : "",
        ),
      ),
    );
  }
}
