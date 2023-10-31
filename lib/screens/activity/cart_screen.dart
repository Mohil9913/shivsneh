import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/model/product.dart';
import 'package:shivsneh/widgets/my_text_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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

          final cart = snapshot.data!.docs[0]['cart'];

          if (cart.length > 0) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final product = cart[index];
                          final title = product['title'];
                          final imageUrl = product['imageUrl'];
                          final quantity = product['quantity'];
                          final price = product['price'];

                          return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: const Icon(Icons.delete),
                            ),
                            onDismissed: (swipe) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Item'),
                                    content: Text('Remove $title from cart?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                        ),
                                        onPressed: () {
                                          final updatedCart = List.from(cart);
                                          updatedCart.remove(product);

                                          final userDocRef =
                                              snapshot.data!.docs[0].reference;

                                          userDocRef
                                              .update({'cart': updatedCart});

                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  '$title | removed from cart'),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            key: UniqueKey(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      child: Image.network(
                                        imageUrl,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          title,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '₹ | $price',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text('X $quantity'),
                                    // Text(
                                    //   '= ${products[index]['quantity'].toInt * products[index]['price'].toInt}',
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 68,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    child: MyTextButton(
                      buttonText: 'Checkout',
                      buttonColor: Colors.green,
                      textColor: Colors.black38,
                      fontSize: 20,
                      buttonHeight: 12,
                      buttonWidth: 0,
                      onClick: () {},
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Empty Cart!\n\nTry Adding Some Items from Home Screen.',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
