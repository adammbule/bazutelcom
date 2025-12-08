import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String details;

  const ProductCard({super.key, required this.name, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(details, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
