import 'package:flutter/material.dart';
import 'package:geek/HomePage.dart';
import 'package:geek/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _mailController.text,
        password: _passwordController.text,
      );
      print('Login successful: ${userCredential.user?.uid}');
      _navigateToHome(context);
    } catch (e) {
      print('Login failed: $e');
      _showAlert('Login failed. Please check your email and password.');
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

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
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
              'GeekLearn',
              style: TextStyle(
                fontSize: 50,
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
                // Add other widgets in the row if needed
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
                // Add other widgets in the row if needed
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
            SizedBox(height: 20),
            Container(
              child: TextButton(
                child: Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                ),
                onPressed: () {
                  _login();
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
                  _navigateToSignup(context);
                },
                child: Text(
                  'create an account?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.facebook, size: 40.0), // Increase the size of the icon
                  onPressed: () {
                    // Add Facebook button logic
                  },
                ),
                InkWell(
                  onTap: () {
                    // Add Gmail button logic
                  },
                  child: Image.asset(
                    'lib/Assets/gmail-removebg-preview.png', // Replace with the actual path to your image asset
                    width: 120.0, // Set the width of the image
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Add Google button logic
                  },
                  child: Image.asset(
                    'lib/Assets/google-removebg-preview.png', // Replace with the actual path to your image asset
                    width: 40.0, // Set the width of the image
                    height: 40.0, // Set the height of the image
                  ),
                ),

                // Add more IconButton widgets as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
