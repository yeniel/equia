import 'package:flutter/material.dart';

import '../home.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination
  });

  final Destination destination;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.destination.key,
      onGenerateRoute: (RouteSettings settings) {
        return widget.destination.route();
      },
    );
  }
}