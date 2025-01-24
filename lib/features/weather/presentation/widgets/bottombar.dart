import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({super.key, required this.onTap});

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.blueAccent,
      backgroundColor: Colors.white,
      items: [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.add, color: Colors.white),
        Icon(Icons.list, color: Colors.white),
      ],
      onTap: onTap,
    );
  }
}
