import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  @override
  _RazorpayScreenState createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clean up the instance
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_hPMMK1uw3WGT1K	', // Replace with your Razorpay API Key
      'amount': 50000, // Amount in the smallest currency unit (e.g., 50000 paise = ₹500)
      'currency': 'INR',
      'name': 'Test Payment',
      'description': 'Demo Payment for Order #12345',
      'prefill': {
        'contact': '9876543210',
        'email': 'lang@gmail.com',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Successful: ${response.paymentId}"),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error Code: ${response.code}");
    print("Error Message: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Failed: ${response.message}"),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("External Wallet Selected: ${response.walletName}"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razorpay Integration"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: Text("Pay with Razorpay"),
        ),
      ),
    );
  }
}

