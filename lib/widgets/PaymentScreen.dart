import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatelessWidget {
  Future<void> makePayment() async {
    try {
      // 1. Fetch Payment Intent Client Secret from your backend
      final response = await http.post(
        Uri.parse('http://192.168.158.66:8000/pi'),
        body: jsonEncode({'amount': 2000, 'currency': 'usd'}),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonResponse = jsonDecode(response.body);
      final clientSecret = jsonResponse['clientSecret'];

      print(jsonResponse);

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.light, // or ThemeMode.dark
          merchantDisplayName: 'Your Company',
        ),
      );

      // 3. Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      print('Payment completed successfully!');
    } catch (e) {
      print('Payment failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stripe Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await makePayment();
          },
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
