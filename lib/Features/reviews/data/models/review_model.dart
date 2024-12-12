class ReviewModel {
  final String review;
  final DateTime dateTime;
  final int rate;
  final String userName;
  final String profilePicture;
  final String userId;

  const ReviewModel({
    required this.review,
    required this.dateTime,
    required this.rate,
    required this.userName,
    required this.profilePicture,
    required this.userId,
  });

  factory ReviewModel.fromJson(dynamic json) {
    return ReviewModel(
      review: json['review'],
      dateTime: DateTime.parse(json['dateTime']),
      rate: json['rate'],
      userName: json['userName'],
      profilePicture: json['profilePicture'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "review": review,
      "dateTime": dateTime.toIso8601String(),
      "rate": rate,
      "userName": userName,
      "profilePicture": profilePicture,
      "userId": userId,
    };
  }
}
