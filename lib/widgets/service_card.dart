import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.title,
    required this.desc,
    this.icon = Icons.wifi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.cardHoverDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(desc, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
