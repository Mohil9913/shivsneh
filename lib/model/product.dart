class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.stockAvailable,
    required this.quantity,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final String stockAvailable;
  final String quantity;
}

String? userPhoneNumber;
