import 'package:flutter/material.dart';
import 'package:money_mate/components/logging_button.dart';
import 'package:money_mate/components/logging_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final bool _isLoading = false;

  String? _usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter your username";
    }
    return null;
  }

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Please enter your email";
    }
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter a password";
    }

    List<String> errors = [];

    if (password.length < 8) {
      errors.add("At least 8 characters");
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("At least one uppercase letter (A-Z)");
    }
    if (!RegExp(r'a-z').hasMatch(password)) {
      errors.add("At least one lowercase letter (a-z)");
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add("At least one number (0-9)");
    }
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]').hasMatch(password)) {
      errors.add("At least one special character (! @ # ...)");
    }

    if (errors.isEmpty) {
      return null;
    }

    return "Password must contain:\n- ${errors.join("\n- ")}";
  }

  String? _confirmPasswordValidator(String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return "Please confirm your password";
    }

    if (_passwordController.text != confirm) {
      return "Passwords don't match";
    }

    return null;
  }

  String? _onConfirmChanged(String? confirm) {
    if (_passwordController.text != confirm) {
      return "Passwords don't match";
    }

    return null;
  }

  Future<void> _register() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff4CAF50),
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Icon(Icons.wallet, size: 100, color: Colors.white),
                  Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LoggingTextField(
                          hint: "Username",
                          controller: _usernameController,
                          isSecured: false,
                          validator: _usernameValidator,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LoggingTextField(
                          hint: "Email",
                          controller: _emailController,
                          isSecured: false,
                          validator: _emailValidator,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LoggingTextField(
                          hint: "Password",
                          controller: _passwordController,
                          isSecured: true,
                          validator: _passwordValidator,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LoggingTextField(
                          hint: "Confirm Password",
                          controller: _confirmPasswordController,
                          isSecured: true,
                          validator: _confirmPasswordValidator,
                          onChanged: _onConfirmChanged,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  LoggingButton(
                    onPressed: _register,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2,
                          )
                        : Text("Register", style: TextStyle(fontSize: 30)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account?"),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xff4CAF50)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
