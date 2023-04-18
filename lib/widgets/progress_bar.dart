import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}
