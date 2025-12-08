import 'package:bazu_corp_website/pages/apply_form_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/services_page.dart';
import 'pages/products_page.dart';
import 'pages/careers_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(const BazuTelecomm());
}

class BazuTelecomm extends StatelessWidget {
  const BazuTelecomm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bazu Telecomm Ltd",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (_) => const HomePage(),
        '/about': (_) => const AboutPage(),
        '/services': (_) => const ServicesPage(),
        '/products': (_) => const ProductsPage(),
        '/careers': (_) => const CareersPage(),
        '/contact': (_) => const ContactPage(),
        '/apply': (_) => const ApplyFormPage(),
      },
    );
  }
}
