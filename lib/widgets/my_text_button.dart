import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.fontSize,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.onClick,
  });

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final double buttonHeight;
  final double buttonWidth;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: buttonHeight, horizontal: buttonWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
