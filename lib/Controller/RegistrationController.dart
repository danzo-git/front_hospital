import 'dart:convert';


import 'package:hospitalfront/Model/PatientData.dart';
import 'package:http/http.dart' as http;
class Registrationcontroller {
  
  Future<http.Response> createPatient(PatientData patient) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/patient/create'),
      headers: <String, String>{
        'Content-Type': 'application/ld+json',
      },
      body: jsonEncode(patient.toJson()),
    );

    if (response.statusCode == 201) {
      // Si la requête a réussi et les données ont été insérées
      return response;
    } else {
      // Si la requête a échoué
      throw Exception('Échec de la création du patient');
    }
  }

  
}
