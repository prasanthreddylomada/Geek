import 'package:flutter/material.dart';
import 'package:geek/LoginPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height:200),
          Container(
            child: Image.asset('lib/Assets/Screenshot 2023-11-21 223522.png'),
          ),
          Container(
            child: Text('Wanna Learn',
              style: TextStyle(
                  fontSize: 30.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                ),
              ),
            ),
          Container(
            child: Text('Start your journey'),
          ),
          SizedBox(height:40),
          Container(
            child: TextButton(
              child: Icon(
                Icons.arrow_forward,
                size: 36.0,
                ),
              onPressed: (){
                _navigateToLogin(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(156, 191, 96, 1) ,// Set the background color to #09bbe6
                onPrimary: Colors.white, // Set the text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the border radius
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}
