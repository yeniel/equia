import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final displayedText = text;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(),
          if (displayedText != null)
            _getText(displayedText: displayedText, context: context),
        ],
      ),
    );
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator(strokeWidth: 3)));
  }

  Text _getText({required String displayedText, required BuildContext context}) {
    var textTheme = Theme.of(context).textTheme;

    return Text(
      displayedText,
      style: textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}
