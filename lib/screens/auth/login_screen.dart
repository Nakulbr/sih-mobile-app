import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/constants/images.dart';
import 'package:sih_hackathon/screens/auth/register_screen.dart';
import 'package:sih_hackathon/screens/home_screen.dart';
import 'package:sih_hackathon/screens/profile_screen.dart';
import 'package:sih_hackathon/screens/wallet_screen.dart';
import 'package:sih_hackathon/utils/show_snackbar.dart';
import 'package:sih_hackathon/widgets/continue_with_button.dart';
import 'package:sih_hackathon/widgets/custom_elevated_button.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';
import 'package:sih_hackathon/widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      content: "Toll",
                      fontWeight: CustomFontWeight.bold,
                      fontSize: 50,
                    ),
                    CustomText(
                      content: "Tag",
                      fontWeight: CustomFontWeight.bold,
                      fontSize: 50,
                      fontColor: primaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        content: "Welcome Back",
                        fontWeight: CustomFontWeight.semibold,
                        fontSize: 20,
                      ),
                      const CustomText(
                        content: "Login to start your journey",
                        fontWeight: CustomFontWeight.normal,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        textEditingController: _emailController,
                        textInputType: TextInputType.text,
                        labelText: "Email",
                        hintText: "Enter your email",
                        prefixIcon: Icons.mail_outline,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: Icons.password,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        width: size.width,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        content: "Sign In",
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: CustomText(
                          content: "Or sign in with",
                          fontWeight: CustomFontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ContinueWithButton(
                              onPressed: () {},
                              platform: "Google",
                              platformIcon: googleLogo,
                            ),
                            const SizedBox(height: 16),
                            ContinueWithButton(
                              onPressed: () {},
                              platform: "Apple",
                              platformIcon: appleLogo,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      content: "Are you new here?",
                      fontWeight: CustomFontWeight.normal,
                      fontSize: 14,
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const CustomText(
                        content: "Register Here",
                        fontWeight: CustomFontWeight.normal,
                        fontSize: 14,
                        fontColor: primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
