import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/section_title.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavBar(),
            SectionTitle("Contact Us"),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "Bazu Telecomm Ltd\n"
                "Bungoma Town, Kenya\n\n"
                "Phone: +254 7XX XXX XXX\n"
                "Email: info@bazutel.com",
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
