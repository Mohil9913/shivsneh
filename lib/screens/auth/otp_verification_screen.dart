import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/screens/other/address_screen.dart';
import 'package:shivsneh/widgets/app_bar.dart';
import 'package:shivsneh/widgets/bottom_navbar.dart';
import 'package:shivsneh/widgets/my_text_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.verify,
    required this.number,
  });

  final String verify;
  final String number;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreen();
}

class _OtpVerificationScreen extends State<OtpVerificationScreen> {
  final _form = GlobalKey<FormState>();
  var _otp = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submit(String number) async {
    _form.currentState!.validate();
    _form.currentState!.save();

    if (_otp.length == 6) {
      setState(() {
        _isLoading = true;
      });
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: widget.verify, smsCode: _otp);
        await _auth.signInWithCredential(credential);
        if (!context.mounted) {
          return;
        }

        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(number);

        await userDocRef.get().then((documentSnapshot) {
          setState(() {
            _isLoading = false;
          });
          if (documentSnapshot.exists) {
            print('$number is in database!!!');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const BottomNavbar(),
              ),
            );
          } else {
            print('$number is NOT in database!!!');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => AddressScreen(phoneNumber: number),
              ),
            );
          }
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        if (!context.mounted) {
          return;
        }

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? 'Authentication Failed!',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 197, 197),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyAppBar(
              titleColor: Colors.black,
            ),
            const Image(
              width: 350,
              image: AssetImage('assets/images/otpImage.png'),
            ),
            Container(
              height: 60,
              width: 270,
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Center(
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      enabled: !_isLoading,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length != 6) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter a valid OTP.',
                              ),
                            ),
                          );
                        }
                      },
                      onSaved: (value) {
                        _otp = value!;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'OTP',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.black38,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              SizedBox(
                width: 180,
                child: MyTextButton(
                  buttonText: 'Confirm',
                  buttonColor: Colors.green,
                  textColor: Colors.black38,
                  fontSize: 20,
                  buttonHeight: 12,
                  buttonWidth: 0,
                  onClick: () {
                    _submit(widget.number);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
