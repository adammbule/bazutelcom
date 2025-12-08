import 'package:bazu_corp_website/widgets/navbar.dart';
import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import '../widgets/job_card.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            const SizedBox(height: 30),
            Text(
              "Careers at Bazu Telecom Ltd",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Join our growing team in Bungoma!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            JobCard(
              title: "Network Technician Intern",
              description:
                  "Responsible for fiber installation, WiFi hotspot setup, and network configurations.",
              onApply: () => Navigator.pushNamed(context, "/apply"),
            ),

            JobCard(
              title: "Sales & Marketing Intern",
              description:
                  "Help connect customers in Bungoma to high-speed fiber and hotspot services.",
              onApply: () => Navigator.pushNamed(context, "/apply"),
            ),

            JobCard(
              title: "Customer Experience Intern",
              description:
                  "Offer customer assistance, ticketing and service coordination.",
              onApply: () => Navigator.pushNamed(context, "/apply"),
            ),

            const SizedBox(height: 60),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
