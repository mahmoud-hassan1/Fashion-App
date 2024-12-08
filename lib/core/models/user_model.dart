import 'package:online_shopping/constants.dart';

class UserModel {
  static UserModel? _instance;
  final String dateOfBirth;
  final String email;
  final String name;
  final String uid;
  late String profilePicturePath;
  late List<String> favourites;
  late List<String> bag;

  UserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.uid,
    required this.profilePicturePath,
    required this.favourites,
    required this.bag,
  });

  @override
  String toString() {
    return 'UserModel(dateOfBirth: $dateOfBirth, email: $email, name: $name, uid: $uid, favourites: $favourites)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
      profilePicturePath: json['profilePicturePath'] ?? defaultProfileImage,
      favourites: List<String>.from(json['favourites']),
      bag: List<String>.from(json['bag']),
    );
  }

  factory UserModel.init() {
    return UserModel(
      dateOfBirth: '',
      email: '',
      name: '',
      uid: '',
      profilePicturePath: '',
      favourites: [],
      bag: [],
    );
  }

  bool isEqualTo(UserModel userModel) {
    return userModel.dateOfBirth == dateOfBirth &&
        userModel.email == email &&
        userModel.name == name &&
        userModel.uid == uid &&
        userModel.profilePicturePath == profilePicturePath &&
        userModel.favourites.isEmpty &&
        userModel.bag.isEmpty;
  }

  static UserModel getInstance() {
    return _instance ??= UserModel.init();
  }

  static void setInstance(UserModel model) {
    _instance = model;
  }
}
