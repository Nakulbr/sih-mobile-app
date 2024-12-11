import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePayWidget extends StatefulWidget {
  static const String defaultGooglePayConfigString = '''{
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [
        {
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }
      ],
      "merchantInfo": {
        "merchantName": "Example Merchant Name"
      },
      "transactionInfo": {
        "countryCode": "IN",
        "currencyCode": "INR",
        "totalPriceStatus": "FINAL",
        "totalPrice": "1.00"
      }
    }
  }''';

  @override
  _GooglePayWidgetState createState() => _GooglePayWidgetState();
}

class _GooglePayWidgetState extends State<GooglePayWidget> {
  final List<PaymentItem> _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '1.00',
      status: PaymentItemStatus.final_price,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GooglePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(
          GooglePayWidget.defaultGooglePayConfigString,
        ),
        paymentItems: _paymentItems,
        type: GooglePayButtonType.buy,
        margin: const EdgeInsets.only(top: 15.0),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    // Handle the resulting Google Pay token
    debugPrint('Payment result: $paymentResult');
  }
}
