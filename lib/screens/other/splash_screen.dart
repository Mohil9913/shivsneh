import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/widgets/app_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        MyAppBar(
          titleColor: Colors.black,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(),
              SizedBox(
                width: 30,
              ),
              Text('Loading...'),
            ],
          ),
        ),
      ],
    ));
  }
}
