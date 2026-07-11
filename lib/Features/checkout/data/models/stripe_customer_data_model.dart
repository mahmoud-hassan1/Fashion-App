class StripeCustomerDataModel {
  final String email;
  final String name;

  StripeCustomerDataModel({
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}
