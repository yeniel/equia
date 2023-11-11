import 'package:flutter/material.dart';

class Destination {
  const Destination({
    required this.key,
    required this.index,
    required this.icon,
    required this.selectedIcon,
    required this.route,
  });

  final GlobalKey key;
  final int index;
  final IconData icon;
  final IconData selectedIcon;
  final Route Function() route;
}