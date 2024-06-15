import 'package:flutter/material.dart';

class RuiButton extends StatelessWidget {
  final IconData icon;
  final String? lable;
  final VoidCallback onPressed;

  RuiButton({required this.lable, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    if (lable != null && !lable!.isEmpty) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(lable!),
      );
    } else {
      return IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      );
    }
  }
}
