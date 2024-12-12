import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double rate;
  final String sellerId;
  final int stock;
  final double price;
  final double priceBeforeDiscount;
   String image;
  final List<String> categories;
  final DateTime date;
  final String subtitle;
  final List<ReviewModel> reviews;
  final double discount;
   List<String> images;
  ProductModel(  {
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
    required this.images,
    required this.priceBeforeDiscount,
    required this.discount,
  });

  factory ProductModel.fromJson(dynamic json, String id) {
    List<ReviewModel> reviewModels = json['reviews'] != null
        ? List.generate(
            json['reviews'].length,
            (int index) => ReviewModel.fromJson(json['reviews'][index]),
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
   images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
    priceBeforeDiscount: (json['priceBeforeDiscount']??0 as num).toDouble(),
    discount: (json['discount']??0 as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rate': rate,
      'sellerId': sellerId,
      'stock': stock,
      'price': price,
      'image': image,
      'categories': categories,
      'date': date,
      'subtitle': subtitle,
      'reviews': List.generate(reviews.length, (int index) {
        return reviews[index].toMap();
      }),
      'images': images,
      'priceBeforeDiscount': priceBeforeDiscount,
      'discount':discount
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      date:date,
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
       discount: discount,
      images: images,
      priceBeforeDiscount: priceBeforeDiscount
    );
  }

  static double getRate(List<ReviewModel> reviewModels) {
    if (reviewModels.isEmpty) {
      return 0;
    }

    double sum = 0;
    for (ReviewModel review in reviewModels) {
      sum += review.rate;
    }
    sum /= reviewModels.length;
    return sum;
  }
}