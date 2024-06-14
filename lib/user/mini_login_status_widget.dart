import 'package:flutter/material.dart';

class MiniLoginStatusWidget extends StatefulWidget {
  const MiniLoginStatusWidget({super.key});

  @override
  State<MiniLoginStatusWidget> createState() => _MiniLoginStatusWidgetState();
}

class _MiniLoginStatusWidgetState extends State<MiniLoginStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(),
        Text("User"),
      ],
    );
  }
}
