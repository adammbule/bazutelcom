import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/section_title.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 700;

    return PageLayout(
      children: [
        const PageHero(
          title: 'Contact Us',
          subtitle: 'We\'d love to hear from you. Reach out for support or new connections.',
          compact: true,
        ),
        SectionContainer(
          child: isNarrow
              ? Column(children: _contactCards(context))
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _contactCards(context)
                      .map(
                        (card) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: card,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  List<Widget> _contactCards(BuildContext context) {
    return [
      _contactCard(
        context,
        Icons.location_on_outlined,
        'Visit Us',
        'Bazu Telecom Ltd\nBungoma Town, Kenya',
      ),
      _contactCard(
        context,
        Icons.phone_outlined,
        'Call Us',
        '+254 7XX XXX XXX\nMon – Sat, 8am – 6pm',
      ),
      _contactCard(
        context,
        Icons.email_outlined,
        'Email Us',
        'info@bazutel.com\nWe respond within 24 hours',
      ),
    ];
  }

  Widget _contactCard(
    BuildContext context,
    IconData icon,
    String title,
    String details,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(32),
      decoration: AppTheme.cardHoverDecoration,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            details,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
