import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/widgets/app_bar.dart';
import 'package:shivsneh/widgets/my_text_button.dart';

import '../../model/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var counterValue = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('number', isEqualTo: userPhoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Empty Cart!'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!'),
            );
          }

          // final cart = snapshot.data!.docs[0]['cart'].reference;
          final cart = snapshot.data!.docs[0].reference;

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 197, 197, 197),
            body: SingleChildScrollView(
              child: Stack(children: [
                const SizedBox(
                  height: 100,
                  child: MyAppBar(titleColor: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 80, 18, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white70,
                        ),
                        child: Image.network(widget.product.imageUrl),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Text(
                            '1L',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Text(
                            '₹ | ${widget.product.price.toString()}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              if (val > -1) {
                                setState(() {
                                  counterValue = val;
                                });
                              }
                            },
                            count: counterValue,
                            countColor: Colors.black,
                            buttonColor: Colors.green,
                            progressColor: Colors.green,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextButton(
                            buttonText: 'Add to Cart',
                            buttonColor: Colors.green,
                            textColor: Colors.black38,
                            fontSize: 20,
                            buttonHeight: 12,
                            buttonWidth: 40,
                            onClick: () {
                              if (counterValue < 1) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Increase Item Quantity'),
                                  ),
                                );
                              } else {
                                final newCartItem = {
                                  'title': widget.product.title,
                                  'imageUrl': widget.product.imageUrl,
                                  'quantity': counterValue,
                                  'price': widget.product.price,
                                };
                                cart.update({
                                  'cart': FieldValue.arrayUnion([newCartItem])
                                });
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${widget.product.title} x $counterValue added to cart'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'About ${widget.product.title}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.product.description,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
