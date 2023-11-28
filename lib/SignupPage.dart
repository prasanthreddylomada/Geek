import 'package:flutter/material.dart';
import 'package:geek/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // void _signup() {
  //   // Perform signup logic here
  //   print('Username: ${_mailController.text}, Password: ${_passwordController.text}, Confirm Password: ${_confirmPasswordController.text}');
  // }


  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }


  void _signup() async {
    // Validate email format
    final emailRegex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(_mailController.text)) {
      _showAlert('Invalid email format');
      return;
    }

    // Validate password length
    if (_passwordController.text.length < 6) {
      _showAlert('Password must be at least 6 characters');
      return;
    }

    // Validate password and confirm password match
    if (_passwordController.text != _confirmPasswordController.text) {
      _showAlert('Passwords do not match');
      return;
    }

    try {
      // Attempt to create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _mailController.text,
        password: _passwordController.text,
      );

      // Navigate to login page on successful signup
      _navigateToLogin(context);
      print('Signup successful!');
    } catch (e) {
      // Handle signup failure
      print('Signup failed: $e');
      _showAlert('Signup failed. Please try again.');
    }
  }

void _showAlert(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              child: Image.asset('lib/Assets/Screenshot 2023-11-21 232836.png'),
            ),
            Text(
              'GeekLearn Signup',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Mail',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: _mailController,
                decoration: InputDecoration(
                  labelText: 'abc@gmail.com',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: TextButton(
                child: Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                ),
                onPressed: () {
                  _signup();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(156, 191, 96, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: TextButton(
                onPressed: () {
                  _navigateToLogin(context);
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
