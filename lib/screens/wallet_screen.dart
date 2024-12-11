import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/constants/images.dart';
import 'package:sih_hackathon/widgets/GooglePayWidget.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  
  // create a function to add payment
  void addPayment() {
    // add payment logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GooglePayWidget(),
            ListTile(
              title: const CustomText(
                content: "Wallet balance",
                fontWeight: CustomFontWeight.semibold,
                fontSize: 18,
                fontColor: Colors.white,
              ),
              subtitle: const CustomText(
                content: "₹2,458.50",
                fontWeight: CustomFontWeight.bold,
                fontSize: 30,
                fontColor: Colors.white,
              ),
              
              // trailing: ElevatedButton(onPressed: addPayment, child: Text("Add Money")),
              // trailing: GooglePayWidget(),
            ),

            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      content: "Payment Methods",
                      fontWeight: CustomFontWeight.semibold,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      tileColor: Colors.black12.withOpacity(0.05),
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      leading: Image.asset(googlePayLogo),
                      title: const CustomText(
                        content: "Google Pay",
                        fontWeight: CustomFontWeight.semibold,
                        fontSize: 16,
                      ),
                      subtitle: const CustomText(
                        content: "Connected",
                        fontWeight: CustomFontWeight.normal,
                        fontSize: 12,
                        fontColor: Colors.green,
                      ),
                    ),
                    // const SizedBox(height: 16),
                    // ListTile(
                    //   tileColor: Colors.black12.withOpacity(0.05),
                    //   visualDensity: VisualDensity.compact,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   trailing: const Icon(
                    //     Icons.check_circle,
                    //     color: Colors.green,
                    //   ),
                    //   leading: CircleAvatar(
                    //     backgroundColor: Colors.deepOrange.shade50,
                    //     child: const Icon(
                    //       Icons.credit_card_outlined,
                    //       color: Colors.orange,
                    //     ),
                    //   ),
                    //   title: const CustomText(
                    //     content: "**** **** **** 4589",
                    //     fontWeight: CustomFontWeight.semibold,
                    //     fontSize: 16,
                    //   ),
                    //   subtitle: const CustomText(
                    //     content: "Expires 12/25",
                    //     fontWeight: CustomFontWeight.normal,
                    //     fontSize: 12,
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          overlayColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(
                            width: 1,
                            color: primaryColor,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32),
                            ),
                          ),
                        ),
                        child: const CustomText(
                          content: "+ Add Payment Method",
                          fontWeight: CustomFontWeight.normal,
                          fontSize: 16,
                          fontColor: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          content: "Recent Transactions",
                          fontWeight: CustomFontWeight.semibold,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              // color: Colors.white,
                            ),
                          ),
                          title: const CustomText(
                            content: "Toll Payment",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                          ),
                          subtitle: const CustomText(
                            content: "Today, 2:30 PM",
                            fontWeight: CustomFontWeight.normal,
                            fontSize: 12,
                          ),
                          trailing: const CustomText(
                            content: "-₹250",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                            // fontColor: Colors.white,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_downward_rounded,
                              // color: Colors.white,
                            ),
                          ),
                          title: const CustomText(
                            content: "Added Money",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                          ),
                          subtitle: const CustomText(
                            content: "Yesterday, 6:45 PM",
                            fontWeight: CustomFontWeight.normal,
                            fontSize: 12,
                          ),
                          trailing: const CustomText(
                            content: "+₹1,000",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                            // fontColor: Colors.white,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              // color: Colors.white,
                            ),
                          ),
                          title: const CustomText(
                            content: "Toll Payment",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                          ),
                          subtitle: const CustomText(
                            content: "Nov 2, 2024, 2:30 PM",
                            fontWeight: CustomFontWeight.normal,
                            fontSize: 12,
                          ),
                          trailing: const CustomText(
                            content: "-₹120",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                            // fontColor: Colors.white,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              // color: Colors.white,
                            ),
                          ),
                          title: const CustomText(
                            content: "Toll Payment",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                          ),
                          subtitle: const CustomText(
                            content: "Oct 4, 2024, 10:30 PM",
                            fontWeight: CustomFontWeight.normal,
                            fontSize: 12,
                          ),
                          trailing: const CustomText(
                            content: "-₹270",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 16,
                            // fontColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
