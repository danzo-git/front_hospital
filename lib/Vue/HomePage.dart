import 'package:flutter/material.dart';
import 'package:hospitalfront/Controller/PatientController.dart';
import 'package:hospitalfront/Model/Doctor.dart';
import 'package:hospitalfront/Model/PatientData.dart';
import 'package:hospitalfront/Vue/Hospital.dart';
import 'package:hospitalfront/Menu.dart';
import 'package:hospitalfront/Vue/RdvPage.dart';
import 'package:hospitalfront/Vue/Component/DoctorCard.dart';
import 'package:hospitalfront/Vue/Component/CategoryButton.dart';
import 'package:hospitalfront/Controller/DoctorController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PatientController _patientController = PatientController();
  String? email;
  String? name;
  String selectedCategory = "All";
  final DoctorController _doctorController = DoctorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<PatientData?>(
          future: _patientController.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Bienvenue');
            } else if (snapshot.hasError) {
              return const Text('Bienvenue');
            } else if (snapshot.hasData) {
              name = snapshot.data?.name ?? 'User';
              email = snapshot.data?.email ?? 'User';
              return Text(
                'Bienvenue $name',
                style: const TextStyle(color: Colors.black),
              );
            } else {
              return const Text('Bienvenue');
            }
          },
        ),
      ),
      drawer: Drawer(
        child: Menu(
          userName: name ?? 'user',
          userEmail: email ?? 'user',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How do you feel?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Fill your medical card right now",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Exemple de changement d'état
                        setState(() {
                          selectedCategory =
                              "Surgeon"; // Simple changement d'état
                        });
                      },
                      child: const Text('Get Started'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'How can we help you?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(
                  icon: Icons.local_hospital,
                  label: 'Dentist',
                  onTap: () {
                    setState(() {
                      // Assurez-vous que 'selectedCategory' est défini comme une variable d'état
                      // dans la classe de votre widget avec état
                      selectedCategory = 'Dentist';
                    });
                  },
                ),
                CategoryButton(
                  icon: Icons.healing,
                  label: 'Surgeon',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'Surgeon';
                    });
                  },
                ),
                CategoryButton(
                  icon: Icons.favorite,
                  label: 'Therapist',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'Therapist';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Doctor List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Doctor>>(
                future: _doctorController.AllDoctor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading doctors list');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DoctorCard(
                            name: snapshot.data![index].name,
                            specialty: snapshot.data![index].speciality,
                            image: 'assets/images/doctor1.jpg',
                          );
                        });
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

    
  





  

