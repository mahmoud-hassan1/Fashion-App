import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

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
  });

  factory ProductModel.fromJson(dynamic json, String id) {
    return ProductModel(
      id: id,
      name: json['name'],
      description: json['description'],
      rate: (json['rate'] as num).toDouble(),
      sellerId: json['sellerId'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      categories: json['categories'].cast<String>(),
      date: (json['date'] as Timestamp).toDate(),
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
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      rate: rate,
      sellerId: sellerId,
      stock: stock,
      price: price,
      image: image,
      categories: categories,
    );
  }
}
