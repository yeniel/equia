import 'package:flutter/material.dart';

class AddChoreFAB extends StatelessWidget {
  const AddChoreFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      shape: const CircleBorder(),
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }
}
