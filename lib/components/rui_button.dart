import 'package:flutter/material.dart';

class RuiButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  RuiButton({required this.text, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
