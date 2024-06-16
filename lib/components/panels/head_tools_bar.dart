import 'package:flutter/material.dart';
import 'package:rui/components/form/rui_input.dart';
import 'package:rui/components/setting/theme_setting_button.dart';

class RuiHeadToolsBar extends StatefulWidget {
  const RuiHeadToolsBar({super.key});

  @override
  State<RuiHeadToolsBar> createState() => _RuiHeadToolsBarState();
}

class _RuiHeadToolsBarState extends State<RuiHeadToolsBar> {
  bool _isSearchActive = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchButton(),
        _buildThemeButton(),
        _buildNotificationsButton(),
        // _buildSettingsButton(),
        // _buildProfileButton(),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildSearchButton() {
    if (_isSearchActive) {
      return SizedBox(
        width: 300,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearchActive = false;
                });
              },
            ),
            RuiInput(
              width: 200,
              labelText: 'Username',
              hintText: 'your username',
              onSubmit: (String vale) {},
              onBlur: () {
                setState(() {
                  _isSearchActive = false;
                });
              },
            ),
          ],
        ),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearchActive = true;
          });
        },
      );
    }
  }

  Widget _buildNotificationsButton() {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        // Handle notifications button press
      },
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        // Handle settings button press
      },
    );
  }

  Widget _buildProfileButton() {
    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        // Handle profile button press
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        // Handle logout button press
      },
    );
  }

  Widget _buildThemeButton() {
    return ThemeSettingButton();
  }

  Widget _buildLanguageButton() {
    return IconButton(
      icon: const Icon(Icons.language),
      onPressed: () {
        // Handle language button press
      },
    );
  }

  Widget _buildMenuButton() {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        // Handle menu button press
      },
    );
  }
}
