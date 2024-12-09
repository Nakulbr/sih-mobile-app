import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sih_hackathon/screens/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _dateOfBirth = '';
  String _vehicleType = 'Bike';
  String _vehicleNumber = '';
  String _password = '';

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Enter your details to get started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.indigoAccent,
        toolbarHeight: 120,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6)
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _fullName = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _dateOfBirthController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your date of birth';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _dateOfBirth = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                color: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6)

                        ),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Vehicle Type',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        value: _vehicleType,
                        items: ['Bike', 'Car', 'Truck', 'Bus', 'Other']
                            .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _vehicleType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Vehicle Number',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your vehicle number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _vehicleNumber = value!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process the registration data
                  }
                },
                child: Text('Register', style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                ),
              ),
              TextButton(
                onPressed: null,
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Login here',
                        style: TextStyle(color: Colors.indigoAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}