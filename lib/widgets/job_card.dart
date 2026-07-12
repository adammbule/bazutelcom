import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onApply;

  const JobCard({
    super.key,
    required this.title,
    required this.description,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.cardHoverDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Internship',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onApply,
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }
}
