import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            _buildFormHead(""),
            _buildFormInput("text", "User name", "Input your username"),
            _buildFormInput("password", "***", "Input your password"),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHead(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildFormInput(
    String type,
    String label,
    String hint,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          print("Login");
        },
        child: Text("Login"),
      ),
    );
  }
}
