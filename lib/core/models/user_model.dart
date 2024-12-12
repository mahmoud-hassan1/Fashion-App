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
  final Role role;

  UserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.uid,
    required this.profilePicturePath,
    required this.favourites,
    required this.bag,
    required this.role,
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
      role: Role.getRole(json['role'] ?? Role.user.value),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'profilePicturePath': profilePicturePath,
      'favourites': favourites.map((e) => e).toList(),
      'bag': bag.map((e) => e).toList(),
      'role': role.value,
    };
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
      role: Role.user,
    );
  }

  bool isEqualTo(UserModel userModel) {
    return userModel.dateOfBirth == dateOfBirth &&
        userModel.email == email &&
        userModel.name == name &&
        userModel.uid == uid &&
        userModel.profilePicturePath == profilePicturePath &&
        userModel.favourites.isEmpty &&
        userModel.bag.isEmpty &&
        userModel.role == role;
  }

  static UserModel getInstance() {
    return _instance ??= UserModel.init();
  }

  static void setInstance(UserModel? model) {
    _instance = model;
  }
}

enum Role {
  user("user"),
  admin("admin");

  final String value;

  static Role getRole(String role) {
    if (role == Role.user.value) {
      return Role.user;
    } else {
      return Role.admin;
    }
  }

  const Role(this.value);
}
