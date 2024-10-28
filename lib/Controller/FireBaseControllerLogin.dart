import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
// import '../constants.dart';

// !NOTE: prefer the flutterfire_ui package, see [FlutterFireLoginUiExample].
// NOTE: to add firebase support, first go to firebase console, generate the
// firebase json file, and add configuration lines in the gradle files.
// C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
class FirebaseControllerLogin extends StatefulWidget {
  const FirebaseControllerLogin({super.key});

  @override
  _FirebaseControllerLoginState createState() => _FirebaseControllerLoginState();
}

class _FirebaseControllerLoginState extends State<FirebaseControllerLogin> {
  final _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? _user;
  // If this._busy=true, the buttons are not clickable. This is to avoid
  // clicking buttons while a previous onTap function is not finished.
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    this._user = _auth.currentUser;
    _auth.authStateChanges().listen((firebase_auth.User? usr) {
      this._user = usr;
      debugPrint('user=$_user');
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleLoginBtn = MaterialButton(
      color: Colors.blueAccent,
      onPressed: this._busy
          ? null
          : () async {
              setState(() => this._busy = true);
              final user = await this._googleSignIn();
              this._showUserProfilePage(user!);
              setState(() => this._busy = false);
            },
      child: const Text('Log in with Google'),
    );
    
    
    
  }

  // Sign in with Google.
  Future<firebase_auth.User?> _googleSignIn() async {
    final curUser = this._user ?? _auth.currentUser;
    if (curUser != null && !curUser.isAnonymous) {
      return curUser;
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
   final user = (await _auth.signInWithCredential(credential)).user;
FirebaseAnalytics.instance.logLogin();
setState(() => this._user = user);
return user;
  }

  // Sign in Anonymously.
  

  

  // Show user's profile in a new screen.
  void _showUserProfilePage(firebase_auth.User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: const Text('user profile'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(title: Text('User: $user')),
              ListTile(title: Text('User id: ${user.uid}')),
              ListTile(title: Text('Display name: ${user.displayName}')),
              ListTile(title: Text('Anonymous: ${user.isAnonymous}')),
              ListTile(title: Text('Email: ${user.email}')),
              ListTile(
                title: const Text('Profile photo: '),
                trailing: user.photoURL != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                      )
                    : CircleAvatar(
                        child: Text(user.displayName![0]),
                      ),
              ),
              ListTile(
                title: Text('Last sign in: ${user.metadata.lastSignInTime}'),
              ),
              ListTile(
                title: Text('Creation time: ${user.metadata.creationTime}'),
              ),
              ListTile(title: Text('ProviderData: ${user.providerData}')),
            ],
          ),
        ),
      ),
    );
  }
}