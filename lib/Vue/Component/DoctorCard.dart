import 'package:flutter/material.dart';

Widget DoctorCard({
  required String name,
  required String specialty,
  required String image,
}) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(name),
        subtitle: Text(specialty),
      ),
    );
}
