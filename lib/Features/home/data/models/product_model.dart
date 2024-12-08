import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double rate;
  final String sellerId;
  final int stock;
  final double price;
  final String image;
  final List<String> categories;
  final DateTime date;
  final String subtitle;
  final List<ProductReviewModel> reviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.sellerId,
    required this.stock,
    required this.price,
    required this.image,
    required this.categories,
    required this.date,
    required this.subtitle,
    required this.reviews,
  });

  factory ProductModel.fromJson(dynamic json, String id) {
    List<ProductReviewModel> reviewModels = json['reviews'] != null
        ? List.generate(
            json['reviews'].length,
            (int index) => ProductReviewModel.fromJson(json['reviews'][index]),
          )
        : [];

    return ProductModel(
      id: id,
      name: json['name'],
      description: json['description'],
      rate: getRate(reviewModels),
      sellerId: json['sellerId'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      categories: json['categories'].cast<String>(),
      date: (json['date'] as Timestamp).toDate(),
      subtitle: json['subtitle'],
      reviews: reviewModels,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rate': rate,
      'sellerId': sellerId,
      'stock': stock,
      'price': price,
      'image': image,
      'categories': categories,
      'date': date.toIso8601String(),
      'subtitle': subtitle,
      'reviews': List.generate(reviews.length, (int index) {
        return reviews[index].toMap();
      }),
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      rate: getRate(reviews),
      sellerId: sellerId,
      stock: stock,
      price: price,
      image: image,
      categories: categories,
      subtitle: subtitle,
      reviews: reviews,
    );
  }

  static double getRate(List<ProductReviewModel> reviewModels) {
    if (reviewModels.isEmpty) {
      return 0;
    }

    double sum = 0;
    for (ProductReviewModel review in reviewModels) {
      sum += review.rate;
    }
    sum /= reviewModels.length;
    return sum;
  }
}
