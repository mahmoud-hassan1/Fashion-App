class OrderReviewModel {
  final DateTime date;
  final String review;
  final int rate;

  const OrderReviewModel({
    required this.date,
    required this.review,
    required this.rate,
  });

  factory OrderReviewModel.fromJson(dynamic json) {
    return OrderReviewModel(
      date: DateTime.parse(json['date']),
      review: json['review'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'review': review,
      'rate': rate,
    };
  }
}
