import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rui/theme_model.dart';
import 'package:rui/theme/rui_theme.dart';

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
          value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.dark,
          onChanged: (bool? value) {
            Provider.of<ThemeModel>(context, listen: false)
                .setThemeMode(ThemeMode.dark);

            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.dark);
          },
          trailingIcon: const Icon(Icons.dark_mode),
          child: const Text('Dark'),
        ),
        CheckboxMenuButton(
          value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.light,
          onChanged: (bool? value) {
            Provider.of<ThemeModel>(context, listen: false)
                .setThemeMode(ThemeMode.light);
            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.light);
          },
          trailingIcon: const Icon(Icons.light_mode),
          child: const Text('Light'),
        ),
        CheckboxMenuButton(
          value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.system,
          onChanged: (bool? value) {
            Provider.of<ThemeModel>(context, listen: false)
                .setThemeMode(ThemeMode.system);
            if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.system);
          },
          trailingIcon: const Icon(Icons.light_mode),
          child: const Text('System'),
        ),
        const PopupMenuDivider(),
        ...themeColorMap.keys.map((key) {
          return MenuItemButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(themeColorMap[key]!),
            ),
            child: Row(
              children: [Icon(Icons.color_lens_outlined), Text(key)],
            ),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).setTheme(key);
              if (onThemeColorChange != null)
                onThemeColorChange!(themeColorMap[key]!);
            },
          );
        }).toList(),
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
