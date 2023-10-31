import 'package:flutter/material.dart';
import 'package:shivsneh/screens/auth/phone_number_verification_screen.dart';
import 'package:shivsneh/widgets/app_bar.dart';
import 'package:shivsneh/widgets/my_elevated_button.dart';
import 'package:transparent_image/transparent_image.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

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
        letterSpacing: 1,
        fontWeight: fontWeight,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: const AssetImage('assets/background/homeBG.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          const MyAppBar(
            titleColor: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '"The Master\'s Eye\nis the Best',
                    style: changeFonts(
                      30,
                      Colors.white,
                      FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Fertilizer',
                        style: changeFonts(
                          45,
                          Colors.green,
                          FontWeight.w400,
                        ),
                      ),
                      Text(
                        '"',
                        style: changeFonts(
                          30,
                          Colors.white,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                MyElevatedButton(
                  imageUrl: 'assets/images/phone.png',
                  buttonText: 'Phone Login',
                  buttonColor: const Color.fromARGB(100, 255, 255, 255),
                  textColor: Colors.black,
                  imageSize: 30,
                  buttonPadding: 13,
                  spaceBetween: 10,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const PhoneNumberVerification(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
