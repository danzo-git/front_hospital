import 'package:flutter/material.dart';

Widget CategoryButton({
  required String label,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple[100],
          child: Icon(icon),
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    ),
  );
}
