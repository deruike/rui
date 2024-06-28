import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotFoundPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotFoundPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
