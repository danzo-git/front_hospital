import 'package:flutter/material.dart';
import 'package:hospitalfront/Vue/Connexion.dart';

void main() => runApp(HealthCareApp());

class HealthCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care Sign In/Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SignInSignUpScreen(),
    );
  }
}

class SignInSignUpScreen extends StatefulWidget {
  @override
  _SignInSignUpScreenState createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.health_and_safety,
                size: 100,
                color: Colors.teal,
              ),
              SizedBox(height: 20),
              Text(
                isSignUp ? 'Create Your Account' : 'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              if (isSignUp) SizedBox(height: 15),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connexion()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  backgroundColor: Colors.teal,
                ),
                child: Text(
                  isSignUp ? 'Sign Up' : 'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    isSignUp = !isSignUp;
                  });
                },
                child: Text(
                  isSignUp
                      ? 'Already have an account? Sign In'
                      : 'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
