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
    required this.images,
    required this.priceBeforeDiscount,
    required this.discount,
  });

  factory ProductModel.fromJson(dynamic json, String id) {
    List<ReviewModel> reviewModels = json[reviewsKey] != null
        ? List.generate(
            json[reviewsKey].length,
            (int index) => ReviewModel.fromJson(json[reviewsKey][index]),
          )
        : [];

    return ProductModel(
      id: id, 
      name:"${json[nameKey].toString()[0].toUpperCase()}${json[nameKey].toString().substring(1).toLowerCase()}",
      description: json[descriptionKey],
      rate: getRate(reviewModels),
      sellerId: json[sellerIdKey],
      stock: json[stockKey],
      price: (json[priceKey] as num).toDouble(),
      image: json[imageKey],
      categories: json[categoriesKey].cast<String>(),
      date: (json[dateKey] as Timestamp).toDate(),
      subtitle: "${json[subtitleKey].toString()[0].toUpperCase()}${json[subtitleKey].toString().substring(1).toLowerCase()}",
      reviews: reviewModels,
      images: (json[imagesKey] as List<dynamic>?)?.cast<String>() ?? [],
      priceBeforeDiscount: (json[priceBeforeDiscountKey] ?? 0 as num).toDouble(),
      discount: (json[discountKey] ?? 0 as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      nameKey: name,
      descriptionKey: description,
      rateKey: rate,
      sellerIdKey: sellerId,
      stockKey: stock,
      priceKey: price,
      imageKey: image,
      categoriesKey: categories,
      dateKey: date,
      subtitleKey: subtitle,
      reviewsKey: List.generate(reviews.length, (int index) => reviews[index].toMap()),
      imagesKey: images,
      priceBeforeDiscountKey: priceBeforeDiscount,
      discountKey: discount
    };
  }

  static String nameKey = 'name';
  static String descriptionKey = 'description';
  static String rateKey = 'rate';
  static String sellerIdKey = 'sellerId';
  static String stockKey = 'stock';
  static String priceKey = 'price';
  static String imageKey = 'image';
  static String categoriesKey = 'categories';
  static String dateKey = 'date';
  static String subtitleKey = 'subtitle';
  static String reviewsKey = 'reviews';
  static String imagesKey = 'images';
  static String priceBeforeDiscountKey = 'priceBeforeDiscount';
  static String discountKey = 'discount';

  Product toEntity() {
    return Product(
        id: id,
        date: date,
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
        priceBeforeDiscount: priceBeforeDiscount);
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
