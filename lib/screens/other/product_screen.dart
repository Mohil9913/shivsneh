import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shivsneh/widgets/product_screen_data.dart';

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

          return ProductScreenData(
            product: widget.product,
            cart: cart,
          );
        });
  }
}
