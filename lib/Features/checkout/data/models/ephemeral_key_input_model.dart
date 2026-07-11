class EphemeralKeyInputModel {
  final String stripeCustomerID;

  EphemeralKeyInputModel({
    required this.stripeCustomerID,
  });

  Map<String, dynamic> toJson() {
    return {
      "customer": stripeCustomerID,
    };
  }
}
