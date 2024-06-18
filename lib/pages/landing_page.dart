import 'package:flutter/material.dart';
import 'package:rui/pages/login_page.dart';
import 'package:rui/storage/rui_storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  Widget home;

  LandingPage({
    Key? key,
    required this.home,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    getUserStatus().then((String? userStatus) {
      if (userStatus != null) {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return widget.home;
        }));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return LoginPage();
        }));
      }
    });
  }

  Future<void> loadSettings() async {
    await RuiStorageManager.load();
  }

  Future<String?> getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStatus = await prefs.getString('userstatus');
    print("==On Load Check ==");
    print(userStatus);
    return userStatus;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LandingPage is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
