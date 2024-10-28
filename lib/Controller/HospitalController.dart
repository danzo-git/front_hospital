import 'dart:convert';

import 'package:hospitalfront/Model/HospitalData.dart';
import 'package:http/http.dart' as http;

class HospitalController { 
 Future<List<HospitalData>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/hospitals'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print(response.body[2]);
      var body = jsonDecode(response.body);

      if (body == null || body['hydra:member'] == null) {
        throw Exception('No data found');
      }

      List<HospitalData> hospitals = List.empty(growable: true);
      for (var item in body['hydra:member']) {
        hospitals.add(HospitalData.fromJson(item));
      }
      return hospitals;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      print("Error: ${response.body}");
      throw Exception('Failed to load hospital data');
    }
  }
}


