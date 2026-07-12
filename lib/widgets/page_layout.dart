import 'package:flutter/material.dart';
import 'navbar.dart';
import 'footer.dart';

class PageLayout extends StatelessWidget {
  final List<Widget> children;
  final bool showFooter;

  const PageLayout({
    super.key,
    required this.children,
    this.showFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NavBar(),
            ...children,
            if (showFooter) const Footer(),
          ],
        ),
      ),
    );
  }
}
