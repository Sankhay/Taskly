import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final VoidCallback onPressed; 

  const HomePageButton({super.key, required this.backgroundColor, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    final Color oppositeColor = getComplementaryColor(backgroundColor);

    return 
      SizedBox(
        height: 100,
        child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.5,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: oppositeColor),
            ),
        ),
        child: Text(
        title,
        style: TextStyle(color: oppositeColor),
      ),
    ),
  ),
);
  }
}

Color getComplementaryColor(Color color) {
    return Color.fromRGBO(
      255 - color.red,
      255 - color.green,
      255 - color.blue,
      1.0,
    );
  }