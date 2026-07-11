class InitPaymentSheetModel {
  final String paymentIntentClientSecret;
  final String customerId;
  final String ephemeralKey;

  InitPaymentSheetModel({
    required this.paymentIntentClientSecret,
    required this.customerId,
    required this.ephemeralKey,
  });
}
