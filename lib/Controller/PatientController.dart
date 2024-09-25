import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospitalfront/Model/PatientData.dart';

class PatientController {
  final String apiUrl = 'http://10.0.2.2:8000/api/me';
  //recuperer le token
   // Récupérer le token depuis SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Utilisez la même clé que celle utilisée dans ConnexionController
    return prefs.getString('token');  // Ici, utilisez 'token' au lieu de 'jwt_token'
  }

  // Récupérer les informations de l'utilisateur
  Future<PatientData?> fetchUser() async {
    final token = await _getToken();
  print(token);

    if (token == null) {
       throw Exception('No token found'); // Aucun token trouvé
    }
//test de la reponse
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token', // Envoyer le token JWT
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PatientData.fromJson(jsonResponse);

    } else {
      print(
          'Erreur lors de la récupération des données utilisateur : ${response.statusCode}');
      throw Exception('Erreur lors de la sélection des données utilisateur');
    }
  }
}
