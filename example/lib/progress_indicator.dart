import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
