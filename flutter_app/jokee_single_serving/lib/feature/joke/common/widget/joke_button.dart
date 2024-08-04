import 'package:flutter/material.dart';
import 'package:jokee_single_serving/feature/joke/common/utils/joke_colors.dart';

class JokeButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String title;
  final Color? color;
  final Color? textColor;
  const JokeButton(
      {super.key,
      this.onPress,
      required this.title,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 120,
        color: color,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? JokeColor.whiteTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
