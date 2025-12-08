import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Bazu Telecom Ltd"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/"),
          child: const Text("Home", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/products"),
          child: const Text("Products", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/services"),
          child: const Text("Services", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/about"),
          child: const Text("About", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/careers"),
          child: const Text("Careers", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
