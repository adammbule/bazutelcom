import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            const SectionTitle("Telecom Equipment"),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                ProductCard(
                  name: "Routers",
                  details:
                      "High-performance routers for home, office and ISP use.",
                ),
                ProductCard(
                  name: "Fiber Cables",
                  details: "Quality fiber optic cables of various lengths.",
                ),
                ProductCard(
                  name: "Access Points",
                  details: "Wifi hotspot radios and long-range AP devices.",
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
