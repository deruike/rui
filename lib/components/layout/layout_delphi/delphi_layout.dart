import 'package:flutter/material.dart';
import 'package:rui/layout/layout_delphi/delphi_container.dart';

class DelphiLayout extends DelphiContainer {
  DelphiLayout({
    super.key,
    required List<Widget> children,
    bool anchorLeft = true,
    bool anchorTop = true,
    bool anchorRight = false,
    bool anchorBottom = false,
    double width = 0,
    double height = 0,
    double left = 0,
    double top = 0,
  }) : super(
          children: children,
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print("constraints $constraints");
      return Wrap(
        children: children,
      );
    });
  }
}
