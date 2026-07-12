import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String details;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.name,
    required this.details,
    this.icon = Icons.devices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.cardHoverDecoration,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient.gradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            details,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
