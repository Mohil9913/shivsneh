import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.imageUrl,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.imageSize,
    required this.buttonPadding,
    required this.spaceBetween,
    required this.onClick,
  });

  final String imageUrl;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double imageSize;
  final double buttonPadding;
  final double spaceBetween;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    TextStyle changeFonts(
      double fSize,
      Color fontColor,
      FontWeight fontWeight,
    ) {
      return TextStyle(
        color: fontColor,
        fontSize: fSize,
        fontWeight: fontWeight,
      );
    }

    return ElevatedButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: buttonPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageUrl),
              width: imageSize,
            ),
            SizedBox(
              width: spaceBetween,
            ),
            Text(
              buttonText,
              style: changeFonts(
                20,
                textColor,
                FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
