import 'package:flutter/material.dart';
import 'package:geek/HomePage.dart';
import 'package:geek/SignupPage.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Perform login logic here
    print('Username: ${_usernameController.text}, Password: ${_passwordController.text}');
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
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
                    'Username',
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
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
                  _navigateToHome(context);
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
