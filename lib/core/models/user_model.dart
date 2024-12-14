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
      uid: json[uidKey],
      name: json[nameKey],
      email: json[emailKey],
      dateOfBirth: json[dateOfBirthKey],
      profilePicturePath: json[profilePicturePathKey] ?? defaultProfileImage,
      favourites: List<String>.from(json[favouritesKey]),
      bag: List<String>.from(json[bagKey]),
      role: Role.getRole(json[roleKey] ?? Role.user.value),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      uidKey: uid,
      nameKey: name,
      emailKey: email,
      dateOfBirthKey: dateOfBirth,
      profilePicturePathKey: profilePicturePath,
      favouritesKey: favourites.map((e) => e).toList(),
      bagKey: bag.map((e) => e).toList(),
      roleKey: role.value,
    };
  }

  static String uidKey = 'uid';
  static String nameKey = 'name';
  static String emailKey = 'email';
  static String dateOfBirthKey = 'dateOfBirth';
  static String profilePicturePathKey = 'profilePicturePath';
  static String favouritesKey = 'favourites';
  static String bagKey = 'bag';
  static String roleKey = 'role';

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
