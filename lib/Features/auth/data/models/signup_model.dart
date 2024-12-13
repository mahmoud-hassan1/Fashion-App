import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';

class SignupModel {
  final String email;
  final String name;
  final DateTime dateOfBirth;
  late String? uid;

  SignupModel({required this.email, required this.name, required this.dateOfBirth, this.uid});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'uid': uid,
      'bag': [],
      'favourites': [],
      'orders': [],
      'role': Role.user.value,
      'profilePicturePath': defaultProfileImage,
    };
  }

  factory SignupModel.fromJson(dynamic data) {
    return SignupModel(
      email: data['email'],
      name: data['name'],
      dateOfBirth: DateTime.parse(data['dateOfBirth']),
      uid: data['uid'],
    );
  }
}
