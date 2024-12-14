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

  static String reviewKey = 'review';
  static String dateTimeKey = 'dateTime';
  static String rateKey = 'rate';
  static String userNameKey = 'userName';
  static String profilePictureKey = 'profilePicture';
  static String userIdKey = 'userId';

  factory ReviewModel.fromJson(dynamic json) {
    return ReviewModel(
      review: json[reviewKey],
      dateTime: DateTime.parse(json[dateTimeKey]),
      rate: json[rateKey],
      userName: json[userNameKey],
      profilePicture: json[profilePictureKey],
      userId: json[userIdKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      reviewKey: review,
      dateTimeKey: dateTime.toIso8601String(),
      rateKey: rate,
      userNameKey: userName,
      profilePictureKey: profilePicture,
      userIdKey: userId,
    };
  }
}
