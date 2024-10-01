import 'package:flutter/material.dart';
import 'package:hospitalfront/Vue/HomePage.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class ConnexionController {
  //pour exposer le formde connexion
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ConnexionController();
 GlobalKey<FormState> get formKey => _formKey; // Expose the form key
  Future<void> login(BuildContext context,String? email, String? password) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

       if (email == null || password == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email et mot de passe ne peuvent pas être vides')),
        );
        return;
      }
      
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login_check'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
         
         
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Identifiants incorrects')),
        );
        return;
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        // Store the token in SharedPreferences for future use
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      print(token);
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de la connexion')),
        );
      }
    }
  }
}
