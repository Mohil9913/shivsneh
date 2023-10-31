import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/screens/auth/otp_verification_screen.dart';
import 'package:shivsneh/widgets/app_bar.dart';
import 'package:shivsneh/widgets/my_text_button.dart';

class PhoneNumberVerification extends StatefulWidget {
  const PhoneNumberVerification({super.key});

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final _form = GlobalKey<FormState>();
  final _countryCode = '+91';
  var _phoneNumber = '';
  static String _verify = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });
    await _auth.verifyPhoneNumber(
      phoneNumber: _countryCode + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval of SMS code completed
        // This function will be called if the SMS code is automatically retrieved.
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? 'Authentication Failed!',
            ),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        _verify = verificationId;
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => OtpVerificationScreen(
              verify: _verify,
              number: _phoneNumber,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the automatic code retrieval timeout has passed.
      },
    );
  }

  void _submit() {
    _form.currentState!.validate();
    _form.currentState!.save();

    if (_phoneNumber.length == 10) {
      _verifyPhoneNumber(_phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 197, 197),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyAppBar(
              titleColor: Colors.black,
            ),
            const Image(
              width: 350,
              image: AssetImage('assets/images/numberImage.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      '+91',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 270,
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Center(
                      child: Form(
                        key: _form,
                        child: TextFormField(
                          enabled: !_isLoading,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length != 10) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please enter a valid 10 digit phone number.',
                                  ),
                                ),
                              );
                            }
                          },
                          onSaved: (value) {
                            _phoneNumber = value!;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
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
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            if (_isLoading) const CupertinoActivityIndicator(),
            if (!_isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextButton(
                    buttonText: 'Back',
                    buttonColor: Colors.grey,
                    textColor: Colors.black38,
                    fontSize: 20,
                    buttonHeight: 15,
                    buttonWidth: 35,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MyTextButton(
                    buttonText: 'Save',
                    buttonColor: Colors.green,
                    textColor: Colors.black38,
                    fontSize: 20,
                    buttonHeight: 15,
                    buttonWidth: 35,
                    onClick: _submit,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
