// lib/shared/shared_widgets.dart
import 'package:flutter/material.dart';

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget budgetItemRow(String label, String value) {
  return ListTile(
    title: Text(label),
    trailing: Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget addLink(String label, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: onTap ?? () {},
      child: Text(label, style: const TextStyle(color: Colors.blue)),
    ),
  );
}
  