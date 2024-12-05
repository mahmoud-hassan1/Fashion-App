class UserModel {
  static UserModel? _instance;
  final String dateOfBirth;
  final String email;
  final String name;
  final String uid;
  List<String>? favourites;

  UserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.uid,
    this.favourites,
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
      favourites: json['favourites'] != null ? List<String>.from(json['favourites']) : null,
    );
  }

  static UserModel getInstance() {
    _instance ??= UserModel(
        dateOfBirth: '',
        email: '',
        name: '',
        uid: '',
      );
    return _instance!;
  }
  static setInstance(UserModel model) {
    _instance = model;

  }
}
