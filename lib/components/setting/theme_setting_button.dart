import 'package:flutter/material.dart';

class ThemeSettingButton extends StatelessWidget {
  Function(Color)? onThemeColorChange;

  Function(ThemeMode)? onThemeModeChange;
  ThemeSettingButton(
      {super.key, this.onThemeModeChange, this.onThemeColorChange});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      // alignmentOffset: Offset(0, 0),
      menuChildren: [
        CheckboxMenuButton(
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (bool? value) {
            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.dark);
          },
          child: Text('Dark'),
          trailingIcon: Icon(Icons.dark_mode),
        ),
        CheckboxMenuButton(
          value: Theme.of(context).brightness == Brightness.light,
          onChanged: (bool? value) {
            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.light);
          },
          child: Text('Light'),
          trailingIcon: Icon(Icons.light_mode),
        ),
        CheckboxMenuButton(
          value: Theme.of(context).brightness == Brightness.light,
          onChanged: (bool? value) {
            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.system);
          },
          child: Text('System'),
          trailingIcon: Icon(Icons.light_mode),
        ),
        PopupMenuDivider(),
        MenuItemButton(
          child: Text('Blue'),
          onPressed: () {
            if (onThemeColorChange != null) onThemeColorChange!(Colors.blue);
          },
        ),
        MenuItemButton(
          child: Text('Blue gray'),
          onPressed: () {
            if (onThemeColorChange != null)
              onThemeColorChange!(Colors.blueGrey);
          },
        ),
      ],

      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          // focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Icons.palette),
        );
      },
    );
  }
}
