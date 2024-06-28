import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              child: const Text("home")),
          const Text("about"),
        ],
      ),
    );
  }
}
