import 'app_config.dart';
import 'supabase_service.dart';

class PaystackInitResult {
  const PaystackInitResult({
    required this.authorizationUrl,
    required this.reference,
  });

  final String authorizationUrl;
  final String reference;
}

class PaystackService {
  Future<PaystackInitResult> initializeTransaction({
    required String email,
    required int amountKobo,
    required String orderCode,
    required String paymentMethod,
  }) async {
    final response = await SupabaseService.instance.client.functions.invoke(
      'paystack-initialize',
      body: {
        'email': email,
        'amount': amountKobo,
        'callback_url': AppConfig.paystackCallbackUrl,
        'metadata': {
          'order_code': orderCode,
          'payment_method': paymentMethod,
        },
      },
    );

    if (response.status != 200 && response.status != 201) {
      throw StateError('Payment initialization failed: ${response.data}');
    }

    final data = response.data as Map<String, dynamic>;
    final authorizationUrl = data['authorization_url'] as String?;
    final reference = data['reference'] as String?;

    if (authorizationUrl == null || reference == null) {
      throw const FormatException('Invalid Paystack response payload.');
    }

    return PaystackInitResult(
      authorizationUrl: authorizationUrl,
      reference: reference,
    );
  }
}
