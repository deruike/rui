import 'package:flutter/material.dart';

class MiniLoginStatusWidget extends StatefulWidget {
  const MiniLoginStatusWidget({super.key});

  @override
  State<MiniLoginStatusWidget> createState() => _MiniLoginStatusWidgetState();
}

class _MiniLoginStatusWidgetState extends State<MiniLoginStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'MiniLoginStatusWidget is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
