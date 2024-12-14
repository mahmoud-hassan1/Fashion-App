class OrderReviewModel {
  final DateTime date;
  final String review;
  final int rate;

  const OrderReviewModel({
    required this.date,
    required this.review,
    required this.rate,
  });

  static String dateKey = 'date';
  static String reviewKey = 'review';
  static String rateKey = 'rate';

  factory OrderReviewModel.fromJson(dynamic json) {
    return OrderReviewModel(
      date: DateTime.parse(json[dateKey]),
      review: json[reviewKey],
      rate: json[rateKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      dateKey: date.toIso8601String(),
      reviewKey: review,
      rateKey: rate,
    };
  }
}
