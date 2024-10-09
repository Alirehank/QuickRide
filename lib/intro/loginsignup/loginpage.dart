import 'package:flutter/material.dart';
import 'package:quickride/intro/loginsignup/signup.dart';
import '../../auth/firebaseAuth.dart';
import '../../auth/utills/keyfun.dart';
import '../../responsepage/carpage.dart';
import '../../views/forgotpass.dart';
 // Import the ForgotPasswordPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email and password cannot be empty')),
      );
      return;
    }

    try {
      await _authService.signIn(email, password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Carpage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtils.dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: Image.asset(
                    "assets/images/Untitled_design-removebg-preview.png",
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.grey[800],
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.grey[800],
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          onPressed: _submit,
                          child: Text('Sign In'),
                        ),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                          child: Text('Create an account'),
                        ),
                        // Forgot Password Button navigates to ForgotPasswordPage
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
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
