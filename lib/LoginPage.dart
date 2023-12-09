import 'package:flutter/material.dart';
import 'package:geek/HomePage.dart';
import 'package:geek/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  void _handleGoogleSignIn() async {
    try {
      print('Google button called');
      await GoogleSignIn().signOut();
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        print('Google sign-in successful: ${userCredential.user?.uid}');
        
        // Check if you have userCredential and navigate to the home page
        if (userCredential.user != null) {
          _navigateToHome(context);
        }
      } else {
        print('Google sign-in canceled');
      }
    } catch (error) {
      print('Google sign-in failed: $error');
    }
  }

  void _hangleFacebookSignIn() async {
      try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email','public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        print('Facebook sign-in successful: ${userCredential.user?.uid} ${user?.email}');
        _showAlert('Facebook sign-in successful UID: ${user?.uid}\nEmail: ${user?.email}');
        // Check if you have userCredential and navigate to the home page
        if (userCredential.user != null) {
          _navigateToHome(context);
        }
      } else {
        print('Facebook sign-in canceled');
      }
    } catch (error) {
      print('Facebook sign-in failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
            Container(
              margin: EdgeInsets.fromLTRB(10,0,10,5), // Adjust the margin as needed
              child: SignInButton(
                Buttons.facebook,
                onPressed: () {
                  _hangleFacebookSignIn();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10,0,10,5), // Adjust the margin as needed
              child: SignInButton(
                Buttons.google,
                onPressed: () {
                  _handleGoogleSignIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
