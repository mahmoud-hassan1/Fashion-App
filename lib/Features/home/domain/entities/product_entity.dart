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
  
  Product({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.rate, 
    required this.sellerId, 
    required this.stock, 
    required this.price, 
    required this.image, 
    required this.categories
  });
}