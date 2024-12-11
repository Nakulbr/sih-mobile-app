import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/widgets/custom_elevated_button.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';
import 'package:sih_hackathon/widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _vehicleTypeController =
      TextEditingController(text: "Bike");

  final List<String> _vehicleTypes = ['Bike', 'Car', 'Truck', 'Bus', 'Other'];

  void _register() {
    // Register user
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNoController.dispose();
    _dobController.dispose();
    _vehicleNoController.dispose();
    _passwordController.dispose();
    _vehicleNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const ListTile(
          title: CustomText(
            content: "Create Account",
            fontWeight: CustomFontWeight.bold,
            fontSize: 24,
            fontColor: Colors.white,
          ),
          subtitle: CustomText(
            content: "Enter your details to get started",
            fontWeight: CustomFontWeight.normal,
            fontSize: 12,
            fontColor: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: CustomText(
                            content: "Personal Information",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          textEditingController: _nameController,
                          textInputType: TextInputType.text,
                          labelText: "Full Name",
                          hintText: "Enter your full name",
                          prefixIcon: Icons.person,
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
                          textEditingController: _phoneNoController,
                          textInputType: TextInputType.number,
                          labelText: "Mobile Number",
                          hintText: "Enter your mobile number",
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          textEditingController: _dobController,
                          textInputType: TextInputType.datetime,
                          labelText: "DOB",
                          hintText: "Select your DOB",
                          prefixIcon: Icons.calendar_today_outlined,
                          inputType: CustomFormFieldInputType.date,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: CustomText(
                            content: "Vehicle Information",
                            fontWeight: CustomFontWeight.semibold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          textEditingController: _vehicleTypeController,
                          textInputType: TextInputType.text,
                          labelText: "Vehicle Type",
                          hintText: "Select Your vehicle type",
                          prefixIcon: Icons.directions_car_outlined,
                          inputType: CustomFormFieldInputType.select,
                          selectOptions: _vehicleTypes,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          textEditingController: _vehicleNoController,
                          textInputType: TextInputType.text,
                          labelText: "Vehicle Number",
                          hintText: "Enter your vehicle number",
                          prefixIcon: Icons.directions_car_filled,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  onPressed: _register,
                  content: "Create Account",
                  width: double.infinity,
                  isRounded: true,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CustomText(
                    content: "Alread have an account?",
                    fontWeight: CustomFontWeight.normal,
                    fontSize: 14,
                    fontColor: primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
