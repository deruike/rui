import 'package:flutter/material.dart';
import 'package:rui/grid/rui_grid_cell.dart';

class RuiGridRow extends StatelessWidget {
  final List<RuiGridCell> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  double definedLogicColWidth = 1;
  double expandedLogicColWidth = 1;

  RuiGridRow({
    required Key key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 0.0,
  }) : super(key: key);

  void calculateWidth(double maxWidth) {
    if (children.isEmpty) {
      definedLogicColWidth = maxWidth;
      expandedLogicColWidth = maxWidth;
    }

    int definedTotalLogicW = 0;
    int nullCnt = 0;
    int definedCnt = 0;
    for (var child in children) {
      if (child.colSpan == null) {
        nullCnt++;
      } else {
        definedCnt++;
        definedTotalLogicW += child.colSpan!;
      }
    }

    if (definedTotalLogicW + nullCnt > 24) {
      throw Exception("列逻辑宽度综合超过24");
    }

    print(
        "nullCnt $nullCnt , definedCnt $definedCnt , definedTotalLogicW, $definedTotalLogicW ");

    if (nullCnt == 0) {
      definedLogicColWidth = maxWidth / definedTotalLogicW;
    } else {
      // expanded 列的数量多于 剩余可用的列宽，不够分，则扩展列逻辑宽度压缩为1，重新计算各列。
      if (24 - definedTotalLogicW < nullCnt) {
        definedLogicColWidth = maxWidth / (definedTotalLogicW + nullCnt * 1);
        expandedLogicColWidth = definedLogicColWidth;
      } else {
        //expanded 列的数量 少于等于 剩余可用的列宽, 则将剩余的列宽均分给 expanded 列
        //计算固定列的宽度
        definedLogicColWidth = maxWidth / 24;
        //剩下的平均分给expanded 列
        expandedLogicColWidth =
            (maxWidth - definedLogicColWidth * definedTotalLogicW) / nullCnt;
      }
    }
  }

/*grid-breakpoints: (
  xs: 0,
  sm: 576px,
  md: 768px,
  lg: 992px,
  xl: 1200px,
  xxl: 1400px
);
*/

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print("constraints $constraints");
      calculateWidth(constraints.maxWidth);
      return Wrap(
        children: children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return SizedBox(
              width: child.colSpan == null
                  ? expandedLogicColWidth
                  : definedLogicColWidth * (child.colSpan!),
              child: child);
        }).toList(),
      );
    });
  }
}
