import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register.dart'; // Make sure to import the register page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'TollTag',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.0),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Text(
                  'Login to start your journey!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 32.0),
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
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                  obscureText: true,
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
                SizedBox(height: 2.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text('Forgot Password?', style: TextStyle(color: Colors.black.withOpacity(0.4))),
                  ),
                ),
                // SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Process the login data
                    }
                  },
                  child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
                // SizedBox(height: 16.0),
                TextButton(
                  onPressed: null,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Register here',
                          style: TextStyle(color: Colors.indigoAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
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
      ),
    );
  }
}