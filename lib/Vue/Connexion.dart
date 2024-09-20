import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospitalfront/Controller/ConnexionController.dart';




class Connexion extends StatefulWidget {
  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

 
  String? _email;
  String? _password;


  @override
  Widget build(BuildContext context) {
    final ConnexionController _connexionController = ConnexionController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _connexionController.formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true, // Masquer le texte saisi
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value,
                ),
                ElevatedButton(
                  onPressed: () async  => _connexionController.login(context, _email, _password),
                  child: const Text('Soumettre'),
                ),
              ])
              )
              ),
    );
  }
}
