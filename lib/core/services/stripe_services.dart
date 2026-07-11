import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:online_shopping/core/services/api_services.dart';

class StripeServices {
  StripeServices(this.apiServices);

  final ApiServices apiServices;
  final String stripeApiBaseUrl = "https://api.stripe.com/v1/";

  Future<void> initPaymentSheet() async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: "",
        merchantDisplayName: 'Fashion Store',
        customerId: "",
        customerEphemeralKeySecret: "",
      ),
    );
  }
}
