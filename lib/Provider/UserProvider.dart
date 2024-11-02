import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:hospitalfront/Model/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool get isSignedIn => _user != null;

  Future<void> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        _user = UserModel(
          name: account.displayName ?? 'Utilisateur',
          email: account.email,
        );
        notifyListeners();
      }
    } catch (error) {
      print('Erreur de connexion : $error');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _user = null;
      notifyListeners();
    } catch (error) {
      print('Erreur de déconnexion : $error');
      rethrow;
    }
  }
}