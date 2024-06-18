import 'package:flutter/material.dart';

class RuiGridCell extends StatelessWidget {
  final Widget child;

  int? colSpan;

  RuiGridCell({
    super.key,
    required this.child,
    this.colSpan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
