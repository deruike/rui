import 'package:flutter/material.dart';

class RuiTreeListView extends StatefulWidget {
  const RuiTreeListView({super.key});

  @override
  State<RuiTreeListView> createState() => _RuiTreeListViewState();
}

class _RuiTreeListViewState extends State<RuiTreeListView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'RuiTreeListView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
