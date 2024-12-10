import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/constants/images.dart';
import 'package:sih_hackathon/screens/history_screen.dart';
import 'package:sih_hackathon/screens/profile_screen.dart';
import 'package:sih_hackathon/screens/wallet_screen.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class HomeScreenModelSheet extends StatelessWidget {
  const HomeScreenModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.05,
      maxChildSize: 0.75,
      initialChildSize: 0.05,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            gradient: LinearGradient(
              colors: [
                primaryColor,
                secondaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 8,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SliverList.list(
                children: [
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                            content: "Quick Actions",
                            fontWeight: CustomFontWeight.bold,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildIconButtons(
                                icon: Icons.wallet,
                                content: "Wallet",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WalletScreen()),
                                  );
                                },
                              ),
                              _buildIconButtons(
                                icon: Icons.person_rounded,
                                content: "Profile",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()),
                                  );
                                },
                              ),
                              _buildIconButtons(
                                icon: Icons.history,
                                content: "History",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HistoryScreen()),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset(
                            carImage,
                            height: 150,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                          const Divider(
                            color: primaryColor,
                          ),
                          const ListTile(
                            dense: true,
                            title: CustomText(
                              content: "Vehicle Type",
                              fontWeight: CustomFontWeight.semibold,
                              fontSize: 16,
                            ),
                            subtitle: CustomText(
                              content: "SUV",
                              fontWeight: CustomFontWeight.bold,
                              fontSize: 24,
                              fontColor: primaryColor,
                            ),
                            trailing: Icon(
                              Icons.directions_car_filled,
                              color: secondaryColor,
                            ),
                          ),
                          const ListTile(
                            dense: true,
                            title: CustomText(
                              content: "Vehicle Number",
                              fontWeight: CustomFontWeight.semibold,
                              fontSize: 16,
                            ),
                            subtitle: CustomText(
                              content: "KA 01 AB 1234",
                              fontWeight: CustomFontWeight.bold,
                              fontSize: 24,
                              fontColor: primaryColor,
                            ),
                            trailing: Icon(
                              Icons.pin,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButtons({
    required IconData icon,
    required String content,
    required void Function() onPressed,
  }) {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            CustomText(
              content: content,
              fontWeight: CustomFontWeight.normal,
              fontSize: 16,
              fontColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
