class PaymentIntentDataModel {
  final int amount;
  final String currencyCode;
  final bool automaticPaymentMethods;
  final String customerId;

  PaymentIntentDataModel({
    required this.amount,
    required this.currencyCode,
    required this.automaticPaymentMethods,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": "${amount.toString()}00",
      "currency": currencyCode,
      "automatic_payment_methods[enabled]": automaticPaymentMethods.toString(),
      "customer": customerId,
    };
  }
}
