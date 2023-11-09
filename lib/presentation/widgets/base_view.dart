import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child,
            ],
          ),
        ),
      ),
    );
  }
}
