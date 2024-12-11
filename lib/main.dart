import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Assign publishable key to flutter_stripe
  Stripe.publishableKey =
  "pk_test_51QUlehSG5JVi59yMD7GGqUYoBxxFCYVLu7mIAQy47g0uNcb3B1DjqRDQCb24IvtRaaCoTBdKFV5RxYYYVWyudnnX00nHjuTY4r";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      // STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent('100', 'USD');

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: 'Ikay',
        ),
      );

      // STEP 3: Display Payment Sheet
      await displayPaymentSheet();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      // Make POST request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51QUlehSG5JVi59yMm1WmigNxBwSHj9f8HU8mccnHNgDS0ns7oQsqegIWdP41DdPvA4gc7e9amBsQz8lLYo4aWV4Q00vRXSFOuU',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      // Check if response is successful
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create Payment Intent');
      }
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100.0,
              ),
              SizedBox(height: 10.0),
              Text("Payment Successful!"),
            ],
          ),
        ),
      );
      paymentIntent = null;
    } on StripeException catch (e) {
      debugPrint('StripeException: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.cancel,
                size: 100.0,
              ),
              SizedBox(height: 10.0),
              Text("Payment Failed"),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100).toString();
    return calculatedAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await makePayment();
          },
          child: const Text('Make Payment'),
        ),
      ),
    );
  }
}