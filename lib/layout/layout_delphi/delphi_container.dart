import 'package:flutter/material.dart';

class DelphiContainer extends StatelessWidget {
  bool anchorLeft = true;
  bool anchorTop = true;
  bool anchorRight = false;
  bool anchorBottom = false;
  double width = 0;
  double height = 0;
  double left = 0;
  double top = 0;

  final List<Widget> children;

  DelphiContainer({
    super.key,
    required this.children,
    this.anchorLeft = true,
    this.anchorTop = true,
    this.anchorRight = false,
    this.anchorBottom = false,
    this.width = 10,
    this.height = 10,
    this.left = 0,
    this.top = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          ...children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;
            return Positioned(
              left: anchorLeft ? left : null,
              right: anchorRight ? left : null,
              top: anchorTop ? top : null,
              bottom: anchorBottom ? top : null,
              child: child,
            );
          }),
        ],
      );
    });
  }
}
