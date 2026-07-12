import 'package:flutter/material.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        const PageHero(
          title: 'Telecom Equipment',
          subtitle:
              'Quality hardware for homes, offices, and ISP deployments.',
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
                  ProductCard(
                    name: 'Routers',
                    details:
                        'High-performance routers for home, office, and ISP use.',
                    icon: Icons.router,
                  ),
                  ProductCard(
                    name: 'Fiber Cables',
                    details: 'Quality fiber optic cables of various lengths.',
                    icon: Icons.cable,
                  ),
                  ProductCard(
                    name: 'Access Points',
                    details: 'WiFi hotspot radios and long-range AP devices.',
                    icon: Icons.cell_tower,
                  ),
                ],
              ),
              const SizedBox(height: 48),
              const SectionTitle(
                'Need Equipment?',
                subtitle:
                    'Contact us for pricing, availability, and installation support.',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                child: const Text('Request a Quote'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
