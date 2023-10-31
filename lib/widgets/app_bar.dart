import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.titleColor});

  final Color titleColor;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black54,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, bottom: 20),
            child: CustomText(
              titleColor: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final double size = 30;

  const CustomText({super.key, required this.titleColor});

  final Color titleColor;

  TextStyle changeFonts(double fSize) {
    return TextStyle(
      color: titleColor,
      fontSize: fSize,
      letterSpacing: 2,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<InlineSpan> textSpans = [
      TextSpan(
        text: 'S',
        style: changeFonts(size + 6),
      ),
      TextSpan(
        text: 'H',
        style: changeFonts(size),
      ),
      TextSpan(
        text: 'I',
        style: changeFonts(size),
      ),
      TextSpan(
        text: 'V',
        style: changeFonts(size),
      ),
      TextSpan(
        text: 'S',
        style: changeFonts(size + 6),
      ),
      TextSpan(
        text: 'N',
        style: changeFonts(size),
      ),
      TextSpan(
        text: 'E',
        style: changeFonts(size),
      ),
      TextSpan(
        text: 'H',
        style: changeFonts(size),
      ),
    ];

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
