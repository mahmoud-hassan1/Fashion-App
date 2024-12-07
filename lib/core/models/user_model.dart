import 'package:online_shopping/constants.dart';

class UserModel {
  static UserModel? _instance;
  final String dateOfBirth;
  final String email;
  final String name;
  final String uid;
  String? profilePicturePath;
  List<String>? favourites;
  List<String>? bag;

  UserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.uid,
    this.profilePicturePath,
    this.favourites,
    this.bag,
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
      favourites: json['favourites'] != null ? List<String>.from(json['favourites']) : [],
      bag: json['bag'] != null ? List<String>.from(json['bag']) : [],
    );
  }

  factory UserModel.init() {
    return UserModel(
      dateOfBirth: '',
      email: '',
      name: '',
      uid: '',
      profilePicturePath: '',
    );
  }

  bool isEqualTo(UserModel userModel) {
    return userModel.dateOfBirth == dateOfBirth &&
        userModel.email == email &&
        userModel.name == name &&
        userModel.uid == uid &&
        userModel.profilePicturePath == profilePicturePath &&
        userModel.favourites == null &&
        userModel.bag == null;
  }

  void setMyBagItems(dynamic json) {
    bag = json != null ? List<String>.from(json) : null;
  }

  void setFavouritesItems(dynamic json) {
    favourites = json != null ? List<String>.from(json) : null;
  }

  static UserModel getInstance() {
    return _instance ??= UserModel.init();
  }

  static void setInstance(UserModel model) {
    _instance = model;
  }
}
