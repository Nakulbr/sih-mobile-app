// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// class GPayIntegration extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Google Pay with Stripe')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             try {
//               // Create payment intent on the server
//               final paymentIntent = await createPaymentIntent();
//
//               // Present the Google Pay sheet
//               await Stripe.instance.presentGooglePay(
//                 GooglePayParams(
//                   merchantCountryCode: "INR",
//                   totalPriceStatus: 'FINAL',
//                   totalPrice: '10.00',
//                   currencyCode: 'usd',
//                   amount: int.parse(paymentIntent['amount']),
//                 ),
//               );
//
//               // Confirm payment
//               await Stripe.instance.confirmGooglePayPayment(
//                 paymentIntent['client_secret'],
//               );
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Payment successful!')),
//               );
//             } catch (e) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Payment failed: $e')),
//               );
//             }
//           },
//           child: Text('Pay with Google Pay'),
//         ),
//       ),
//     );
//   }
//
//   Future<Map<String, dynamic>> createPaymentIntent() async {
//     // Replace with your server-side code
//     return {
//       'client_secret': 'your-client-secret',
//       'amount': '1000', // Example amount in cents
//     };
//   }
// }
