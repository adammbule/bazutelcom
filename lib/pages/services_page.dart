import 'package:flutter/material.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/service_card.dart';
import '../widgets/section_title.dart';
import '../widgets/hotspot_map.dart';
import '../theme/app_theme.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        const PageHero(
          title: 'Our Services',
          subtitle:
              'From WiFi hotspots to enterprise fiber — internet solutions for every need.',
          compact: true,
        ),
        SectionContainer(
          child: Column(
            children: [
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: const [
                  ServiceCard(
                    title: 'WiFi Hotspot',
                    desc:
                        'Affordable hotspot access for homes, estates, hostels, and shops.',
                    icon: Icons.wifi,
                  ),
                  ServiceCard(
                    title: 'Fiber Home Internet',
                    desc:
                        'Stable and unlimited fiber connectivity for families and residences.',
                    icon: Icons.home_outlined,
                  ),
                  ServiceCard(
                    title: 'Business Fiber Solutions',
                    desc:
                        'Dedicated bandwidth and enterprise-grade connectivity.',
                    icon: Icons.business_center_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.surfaceAlt,
          child: SectionContainer(
            child: Column(
              children: [
                const SectionTitle(
                  'Hotspot Locations',
                  subtitle: 'Find WiFi coverage near you across Bungoma Town.',
                ),
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const HotspotMap(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
