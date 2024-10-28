import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthPage extends StatelessWidget {
  // Méthode pour gérer Google Sign-In
  Future<User?> _signInWithGoogle() async {
    try {
      // Déclenche la fenêtre de sélection de compte Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      // Obtient les détails d'authentification de Google
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Crée une nouvelle crédential avec le token d'authentification
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Connecte l'utilisateur à Firebase avec la crédential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Sign-In")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user = await _signInWithGoogle();
            if (user != null) {
              // Connexion réussie
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Bienvenue, ${user.displayName}")),
              );
            }
          },
          child: Text("Se connecter avec Google"),
        ),
      ),
    );
  }
}
