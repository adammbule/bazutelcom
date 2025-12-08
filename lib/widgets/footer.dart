import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(25),
      child: const Center(
        child: Text(
          "© 2021 Bazu Telecom Ltd - Bungoma, Kenya",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
