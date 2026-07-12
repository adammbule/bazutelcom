import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/section_title.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 700;

    return PageLayout(
      children: [
        const PageHero(
          title: 'About Us',
          subtitle: 'Connecting Bungoma with reliable, modern telecom infrastructure.',
          compact: true,
        ),
        SectionContainer(
          child: isNarrow
              ? _buildContent(context)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContent(context)),
                    const SizedBox(width: 48),
                    Expanded(child: _buildValuesCard(context)),
                  ],
                ),
        ),
        if (isNarrow)
          SectionContainer(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
            child: _buildValuesCard(context),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Who We Are'),
        const SizedBox(height: 32),
        Text(
          'Bazu Telecom Ltd provides high-speed WiFi hotspots, fiber connectivity, '
          'and telecom equipment across Bungoma Town. We pride ourselves on delivering '
          'stable, low-latency internet solutions for homes, businesses, and institutions.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'Founded with a mission to bridge the digital divide in Western Kenya, '
          'we combine local expertise with modern network infrastructure to keep '
          'our community connected.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildValuesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppTheme.cardHoverDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Values',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _valueItem(context, Icons.verified_outlined, 'Reliability',
              'Networks you can depend on, day and night.'),
          const SizedBox(height: 20),
          _valueItem(context, Icons.people_outline, 'Community',
              'Built for Bungoma, by people who live here.'),
          const SizedBox(height: 20),
          _valueItem(context, Icons.trending_up, 'Innovation',
              'Continuously upgrading our infrastructure and services.'),
        ],
      ),
    );
  }

  Widget _valueItem(
    BuildContext context,
    IconData icon,
    String title,
    String desc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(desc, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
