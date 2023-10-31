import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/model/product.dart';
import 'package:shivsneh/widgets/app_bar.dart';
import 'package:shivsneh/widgets/bottom_navbar.dart';
import 'package:shivsneh/widgets/my_text_button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<AddressScreen> createState() => _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<AddressScreen> {
  final form = GlobalKey<FormState>();
  var name = '';
  var blockNo = '';
  var add1 = '';
  var add2 = '';
  var state = '';
  var city = '';
  var pinCode = '';
  var isLoading = false;

  static const double hintTextSize = 23;
  static const double inputTextSize = 20;
  static const String validatorText = 'Can\'t be empty';

  @override
  Widget build(BuildContext context) {
    var phoneNumber = widget.phoneNumber;
    void submit() async {
      final isValid = form.currentState!.validate();
      if (isValid) {
        form.currentState!.save();
        setState(() {
          isLoading = true;
        });
        userPhoneNumber = phoneNumber;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .set({
          'name': name,
          'number': phoneNumber,
          'address': {
            'blockNo': blockNo,
            'add1': add1,
            'add2': add2,
            'state': state,
            'city': city,
            'pinCode': pinCode,
          },
          'cart': [],
        });
        setState(() {
          isLoading = false;
        });

        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const BottomNavbar(),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 197, 197),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Stack(children: [
              const MyAppBar(
                titleColor: Colors.black,
              ),
              if (isLoading) const Center(child: CupertinoActivityIndicator()),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Form(
                          key: form,
                          child: Column(
                            children: [
                              TextFormField(
                                maxLength: 20,
                                decoration: const InputDecoration(
                                  hintText: 'Your Name',
                                  hintStyle: TextStyle(
                                    fontSize: hintTextSize,
                                    color: Colors.black38,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: inputTextSize,
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return validatorText;
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              TextFormField(
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  hintText: 'Block / Shop no',
                                  hintStyle: TextStyle(
                                    fontSize: hintTextSize,
                                    color: Colors.black38,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: inputTextSize,
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return validatorText;
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  blockNo = val!;
                                },
                              ),
                              TextFormField(
                                maxLength: 30,
                                decoration: const InputDecoration(
                                  hintText: 'Address Line 1',
                                  hintStyle: TextStyle(
                                    fontSize: hintTextSize,
                                    color: Colors.black38,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: inputTextSize,
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return validatorText;
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  add1 = val!;
                                },
                              ),
                              TextFormField(
                                maxLength: 30,
                                decoration: const InputDecoration(
                                  hintText: 'Address Line 2',
                                  hintStyle: TextStyle(
                                    fontSize: hintTextSize,
                                    color: Colors.black38,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: inputTextSize,
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return validatorText;
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  add2 = val!;
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 12,
                                      decoration: const InputDecoration(
                                        hintText: 'State',
                                        hintStyle: TextStyle(
                                          fontSize: hintTextSize,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: inputTextSize,
                                        color: Colors.black,
                                      ),
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return validatorText;
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        state = val!;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 12,
                                      decoration: const InputDecoration(
                                        hintText: 'City',
                                        hintStyle: TextStyle(
                                          fontSize: hintTextSize,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: inputTextSize,
                                        color: Colors.black,
                                      ),
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return validatorText;
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        city = val!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Area Pin Code',
                                  hintStyle: TextStyle(
                                    fontSize: hintTextSize,
                                    color: Colors.black38,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: inputTextSize,
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return validatorText;
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  pinCode = val!;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              MyTextButton(
                                buttonText: 'Save',
                                buttonColor: Colors.green,
                                textColor: Colors.black,
                                fontSize: 20,
                                buttonHeight: 15,
                                buttonWidth: 35,
                                onClick: submit,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]),
    );
  }
}
