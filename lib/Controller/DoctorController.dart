import 'dart:convert';

import 'package:hospitalfront/Model/Doctor.dart';
import 'package:http/http.dart' as http;

class DoctorController {
  /**
   * Get doctor by id
   */
  Future<Doctor> getDoctor(int id) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/doctors/$id'));
    if (response.statusCode == 200) {
      return Doctor.fromJson(response.body as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load doctor');
    }
  }
  /**
   * Get all doctor
   */
  List<Doctor> doctors = [];
Future<List<Doctor>> AllDoctor() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/doctors'));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body); 
    if (body == null || body['hydra:member'] == null) {
        throw Exception('No data found');
      }
      for (var item in body['hydra:member']) {
        doctors.add(Doctor.fromJson(item));
      }
      print(doctors.length);
      print(doctors);
      return doctors;

  } else {
    throw Exception('Failed to load doctor');
  }
}

}
