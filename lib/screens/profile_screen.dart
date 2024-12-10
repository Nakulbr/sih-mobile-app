import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const CustomText(
          content: "Profile",
          fontWeight: CustomFontWeight.semibold,
          fontSize: 24,
          fontColor: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: 120,
                  height: 120, // Ensures a square shape
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://pbs.twimg.com/profile_images/1486565931337797634/KXgFzsFK_400x400.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Column(
                children: [
                  CustomText(
                    content: "Paul Finch",
                    fontWeight: CustomFontWeight.semibold,
                    fontSize: 24,
                    fontColor: Colors.white,
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    content: "dev.paulfinch@gmail.com",
                    fontWeight: CustomFontWeight.normal,
                    fontSize: 16,
                    fontColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white, thickness: 1),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    content: "Account",
                    fontWeight: CustomFontWeight.bold,
                    fontSize: 24,
                    fontColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.attach_money_rounded,
                    content: "Payment Options",
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.settings,
                    content: "Settings",
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.notifications_active,
                    content: "Notification Settings",
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.person_rounded,
                    content: "Edit Profile",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    content: "General",
                    fontWeight: CustomFontWeight.bold,
                    fontSize: 24,
                    fontColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.contact_support,
                    content: "Support",
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.shield_rounded,
                    content: "Terms of Service",
                  ),
                  const SizedBox(height: 8),
                  _drawListTile(
                    leadingIcon: Icons.ios_share_rounded,
                    content: "Invite Friends",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawListTile({
    required IconData leadingIcon,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.9),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: primaryColor,
        ),
        title: CustomText(
          content: content,
          fontWeight: CustomFontWeight.semibold,
          fontSize: 16,
          fontColor: primaryColor,
        ),
        trailing: Transform.rotate(
          angle: pi,
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
