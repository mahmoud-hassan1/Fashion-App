import 'package:online_shopping/Features/reviews/data/models/review_model.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double rate;
  final String sellerId;
  final int stock;
  final double price;
  final String image;
  final List<String> categories;
  final String subtitle;
  final List<ReviewModel> reviews;
  final List<String> images;
  final double priceBeforeDiscount;
  final double discount;
  final DateTime date;

  Product({
    required this.date,
    required this.discount,
    required this.priceBeforeDiscount,
    required this.images,
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.sellerId,
    required this.stock,
    required this.price,
    required this.image,
    required this.categories,
    required this.subtitle,
    required this.reviews,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, rate: $rate, sellerId: $sellerId, stock: $stock, price: $price, image: $image, categories: $categories, subTitle: $subtitle, reviews: $reviews)';
  }
}
