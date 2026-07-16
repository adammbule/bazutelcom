import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/section_title.dart';
import '../widgets/feature_card.dart';
import '../widgets/service_card.dart';
import '../widgets/towns_carousel.dart';

/// Towns cycled through in the hero title.
/// Reused here so it's easy to keep in sync with TownsCarousel below.
const List<String> kHeroTowns = [
  'Bungoma',
  'Nairobi',
  'Kisumu',
  'Mombasa',
  'Eldoret',
  'Nakuru',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 700;

    return PageLayout(
      children: [
        const _RotatingHero(),

        // Stats bar
        Container(
          color: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 24 : 48,
            vertical: 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: isNarrow
                  ? const Column(
                      children: [
                        StatBadge(value: '24/7', label: 'Network Support'),
                        SizedBox(height: 24),
                        StatBadge(value: 'Fiber', label: 'Home & Business'),
                        SizedBox(height: 24),
                        StatBadge(value: 'Local', label: 'Bungoma Based'),
                      ],
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatBadge(value: '24/7', label: 'Network Support'),
                        StatBadge(value: 'Fiber', label: 'Home & Business'),
                        StatBadge(value: 'Local', label: 'Bungoma Based'),
                      ],
                    ),
            ),
          ),
        ),

        SectionContainer(
          child: Column(
            children: [
              const SectionTitle(
                'Why Choose Bazu Telecom',
                subtitle:
                    'We deliver fast, reliable, and affordable internet solutions tailored for the Bungoma community.',
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: const [
                  SizedBox(
                    width: 300,
                    child: FeatureCard(
                      icon: Icons.speed,
                      title: 'High-Speed Connectivity',
                      description:
                          'Low-latency fiber and hotspot access designed for streaming, work, and everyday use.',
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: FeatureCard(
                      icon: Icons.savings_outlined,
                      title: 'Affordable Plans',
                      description:
                          'Flexible packages for homes, hostels, shops, and businesses of every size.',
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: FeatureCard(
                      icon: Icons.support_agent,
                      title: 'Local Expert Support',
                      description:
                          'A Bungoma-based team that understands your needs and responds quickly.',
                    ),
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
                  'Our Reach Across Kenya',
                  subtitle:
                      'Serving Bungoma today — expanding to major towns across the country.',
                ),
                const SizedBox(height: 40),
                const TownsCarousel(),
              ],
            ),
          ),
        ),

        Container(color: AppColors.surfaceAlt),
        SectionContainer(
          child: Column(
            children: [
              const SectionTitle(
                'Our Core Services',
                subtitle: 'Everything you need to stay connected.',
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: const [
                  ServiceCard(
                    title: 'WiFi Hotspots',
                    desc:
                        'Affordable hotspot access for homes, estates, hostels, and shops across Bungoma.',
                    icon: Icons.wifi,
                  ),
                  ServiceCard(
                    title: 'Fiber Home Internet',
                    desc:
                        'Stable, unlimited fiber connectivity for families and residential areas.',
                    icon: Icons.home_outlined,
                  ),
                  ServiceCard(
                    title: 'Business Solutions',
                    desc:
                        'Dedicated bandwidth and enterprise-grade connectivity for growing businesses.',
                    icon: Icons.business_center_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/services'),
                child: const Text('View All Services'),
              ),
            ],
          ),
        ),

        // CTA section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 24 : 48,
            vertical: isNarrow ? 48 : 64,
          ),
          decoration: AppTheme.heroGradient,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Text(
                    'Ready to get connected?',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Reach out today and we\'ll help you find the right internet solution.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                    ),
                    child: const Text('Get in Touch'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Wraps [PageHero] and cycles the title through [kHeroTowns] every few
/// seconds, e.g. "Reliable Internet for Nairobi Town".
class _RotatingHero extends StatefulWidget {
  const _RotatingHero();

  @override
  State<_RotatingHero> createState() => _RotatingHeroState();
}

class _RotatingHeroState extends State<_RotatingHero> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        _index = (_index + 1) % kHeroTowns.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageHero(
      title: 'Reliable Internet for ',
      titleWidget: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'Reliable Internet in '),
            TextSpan(
              text: '${kHeroTowns[_index]}',
              style: const TextStyle(color: Colors.red),
            ),
            //const TextSpan(text: ' Town'),
          ],
        ),
      ),
      subtitle:
          'Fast WiFi hotspots, fiber connections, and telecom equipment — built for homes, businesses, and institutions.',
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/services'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
          ),
          child: const Text('Explore Services'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white70),
          ),
          child: const Text('Contact Us'),
        ),
      ],
    );
  }
}
