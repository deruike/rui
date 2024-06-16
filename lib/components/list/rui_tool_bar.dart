import 'package:flutter/material.dart';

class RuiToolBar extends StatefulWidget {
  List<Widget> toolButtonList;
  RuiToolBar({super.key, required this.toolButtonList});

  @override
  State<RuiToolBar> createState() => _RuiToolBarState();
}

class _RuiToolBarState extends State<RuiToolBar> {
  @override
  Widget build(BuildContext context) {
    return Row(children: widget.toolButtonList);
  }
}
