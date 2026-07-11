import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:online_shopping/Features/checkout/data/models/ephemeral_key_input_model.dart';
import 'package:online_shopping/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:online_shopping/Features/checkout/data/models/init_payment_sheet_model.dart';
import 'package:online_shopping/Features/checkout/data/models/payment_intent_data_model.dart';
import 'package:online_shopping/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:online_shopping/Features/checkout/data/models/stripe_customer_data_model.dart';
import 'package:online_shopping/Features/checkout/data/models/stripe_customer_model/stripe_customer_model.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/services/api_services.dart';

class StripeServices {
  StripeServices(this.apiServices);

  final ApiServices apiServices;
  final String stripeApiBaseUrl = "https://api.stripe.com/v1/";

  Future<StripeCustomerModel> createCustomer(
    StripeCustomerDataModel stripeCustomerDataModel,
  ) async {
    Response<dynamic> response = await apiServices.post(
      body: stripeCustomerDataModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: "${stripeApiBaseUrl}customers",
      token: dotenv.env["StripeSecretKey"]!,
    );

    return StripeCustomerModel.fromJson(response.data);
  }

  Future<PaymentIntentModel> createPaymentIntent(
    final PaymentIntentDataModel paymentIntentDataModel,
  ) async {
    Response<dynamic> response = await apiServices.post(
      body: paymentIntentDataModel.toJson()
        ..addAll({"setup_future_usage": "off_session"}),
      contentType: Headers.formUrlEncodedContentType,
      url: "${stripeApiBaseUrl}payment_intents",
      token: dotenv.env["StripeSecretKey"]!,
    );

    return PaymentIntentModel.fromJson(response.data);
  }

  Future<void> initPaymentSheet(
    final InitPaymentSheetModel initPaymentSheetModel,
  ) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        paymentIntentClientSecret:
            initPaymentSheetModel.paymentIntentClientSecret,
        merchantDisplayName: 'Fashion Store',
        customerId: initPaymentSheetModel.customerId,
        customerEphemeralKeySecret: initPaymentSheetModel.ephemeralKey,
        opensCardScannerAutomatically: true,
        billingDetailsCollectionConfiguration:
            const BillingDetailsCollectionConfiguration(
          email: CollectionMode.never,
          name: CollectionMode.never,
          address: AddressCollectionMode.never,
          phone: CollectionMode.never,
        ),
      ),
    );
  }

  Future<void> confirmPayment() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKeyNonce(
    EphemeralKeyInputModel ephemeralKeyInputModel,
  ) async {
    Response<dynamic> response = await apiServices.post(
      body: {"customer": UserModel.getInstance().stripeCustomerID},
      contentType: Headers.formUrlEncodedContentType,
      url: "${stripeApiBaseUrl}ephemeral_keys",
      token: dotenv.env["StripeSecretKey"]!,
      headers: {
        'Stripe-Version': '2026-06-24.dahlia',
      },
    );

    return EphemeralKeyModel.fromJson(response.data);
  }

  Future<void> checkout(
    final PaymentIntentDataModel paymentIntentDataModel,
  ) async {
    final PaymentIntentModel paymentIntentModel =
        await createPaymentIntent(paymentIntentDataModel);

    final EphemeralKeyModel ephemeralKeyModel = await createEphemeralKeyNonce(
      EphemeralKeyInputModel(
        stripeCustomerID: UserModel.getInstance().stripeCustomerID,
      ),
    );

    await initPaymentSheet(
      InitPaymentSheetModel(
        ephemeralKey: ephemeralKeyModel.secret!,
        paymentIntentClientSecret: paymentIntentModel.clientSecret!,
        customerId: paymentIntentDataModel.customerId,
      ),
    );

    await confirmPayment();
  }
}
