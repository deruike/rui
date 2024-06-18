import 'package:flutter/material.dart';
import 'package:rui/grid/rui_grid_row.dart';

class RuiGridContainer extends StatelessWidget {
  RuiGridContainer({
    super.key,
    required this.children,
    this.minCellWidth = 120,
  });

  List<RuiGridRow> children;
  final double minCellWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print(constraints);
      return SingleChildScrollView(
        child: SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: children,
          ),
        ),
      );
    });
  }
}
