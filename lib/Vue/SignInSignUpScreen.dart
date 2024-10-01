import 'package:flutter/material.dart';
import 'package:hospitalfront/Vue/Connexion.dart';
import 'package:hospitalfront/Vue/RegistrationForm.dart';


class HealthCareApp extends StatelessWidget {
  const HealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care Sign In/Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SignInSignUpScreen(),
    );
  }
}

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            const  Icon(
                Icons.health_and_safety,
                size: 100,
                color: Colors.teal,
              ),
            const  SizedBox(height: 20),
              Text(
                isSignUp ? 'Create Your Account' : 'Welcome Back',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              if (isSignUp) const SizedBox(height: 15),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connexion()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  backgroundColor: Colors.teal,
                ),
                child: Text(
                  isSignUp ? 'Sign Up' : 'Sign In',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    isSignUp = !isSignUp;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm()));
                  });
                },
                child: Text(
                  isSignUp
                      ? 'Already have an account? Sign In'
                      : 'Don\'t have an account? Sign Up',
                      
                  style: const TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
