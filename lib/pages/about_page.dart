import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/section_title.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavBar(),
            SizedBox(height: 40),
            SectionTitle("About Us"),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "Bazu Telecomm Ltd provides high-speed Wifi hotspots, "
                "fiber connectivity and telecom equipment across Bungoma Town. "
                "We pride ourselves in delivering stable, low-latency internet "
                "solutions for homes, businesses, and institutions.",
                textAlign: TextAlign.center,
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
