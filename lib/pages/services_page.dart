import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/service_card.dart';
import '../widgets/section_title.dart';
import '../widgets/hotspot_map.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),

            const SectionTitle("Our Services"),
            const SizedBox(height: 20),

            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                ServiceCard(
                  title: "Wifi Hotspot",
                  desc:
                      "Affordable hotspot access for homes, estates, hostels and shops.",
                ),
                ServiceCard(
                  title: "Fiber Home Internet",
                  desc:
                      "Stable and unlimited fiber connectivity for families and residences.",
                ),
                ServiceCard(
                  title: "Business Fiber Solutions",
                  desc:
                      "Dedicated bandwidth and enterprise-grade connectivity.",
                ),
              ],
            ),

            const SizedBox(height: 40),

            const SectionTitle("Hotspot Locations"),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HotspotMap(),
            ),

            const SizedBox(height: 30),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
