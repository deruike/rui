import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/theme/rui_theme.dart';

class ThemeSettingButton extends StatelessWidget {
  Function(Color)? onThemeColorChange;

  Function(ThemeMode)? onThemeModeChange;
  ThemeSettingButton(
      {super.key, this.onThemeModeChange, this.onThemeColorChange});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return MenuAnchor(
      // alignmentOffset: Offset(0, 0),
      menuChildren: [
        CheckboxMenuButton(
          closeOnActivate: false,
          value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.system,
          onChanged: (bool? value) {
            ThemeMode newMode = value ?? false
                ? ThemeMode.system
                : (isDark ? ThemeMode.dark : ThemeMode.light);
            Provider.of<ThemeModel>(context, listen: false)
                .setThemeMode(newMode);
            if (onThemeModeChange != null) onThemeModeChange!(newMode);
          },
          child: Row(children: [
            const Text('深色模式跟随系统'),
            // if (Provider.of<ThemeModel>(context).themeMode != ThemeMode.system)
            Switch(
                value: isDark,
                thumbIcon: MaterialStateProperty.all(isDark
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode_outlined)),
                onChanged: (bool value) {
                  Provider.of<ThemeModel>(context, listen: false)
                      .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  if (onThemeModeChange != null) {
                    onThemeModeChange!(
                        value ? ThemeMode.dark : ThemeMode.light);
                  }
                }),
          ]),
        ),

        // CheckboxMenuButton(
        //   value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.dark,
        //   onChanged: (bool? value) {
        //     Provider.of<ThemeModel>(context, listen: false)
        //         .setThemeMode(ThemeMode.dark);

        //     if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.dark);
        //   },
        //   trailingIcon: const Icon(Icons.dark_mode),
        //   child: const Text('Dark'),
        // ),
        // CheckboxMenuButton(
        //   value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.light,
        //   onChanged: (bool? value) {
        //     Provider.of<ThemeModel>(context, listen: false)
        //         .setThemeMode(ThemeMode.light);
        //     if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.light);
        //   },
        //   trailingIcon: const Icon(Icons.light_mode),
        //   child: const Text('Light'),
        // ),
        // CheckboxMenuButton(
        //   value: Provider.of<ThemeModel>(context).themeMode == ThemeMode.system,
        //   onChanged: (bool? value) {
        //     Provider.of<ThemeModel>(context, listen: false)
        //         .setThemeMode(ThemeMode.system);
        //     if (onThemeModeChange != null) onThemeModeChange!(ThemeMode.system);
        //   },
        //   trailingIcon: const Icon(Icons.light_mode),
        //   child: const Text('System'),
        // ),

        // const PopupMenuDivider(),
        // MenuItemButton(
        //   child: Container(
        //     width: 200,
        //     color: Theme.of(context).colorScheme.primary,
        //     child: Wrap(
        //       direction: Axis.horizontal,
        //       children: themeColorMap.keys.map((key) {
        //         return Expanded(
        //           flex: 2,
        //           child: Container(
        //             width: 50, // Row Expanded下width无效
        //             height: 50, // Column Expanded下height无效
        //             color: Colors.green,
        //             child: MaterialButton(
        //               shape: Border.all(
        //                   color: Colors.deepOrange,
        //                   width: 2.5,
        //                   style: BorderStyle.solid),
        //               color: themeColorMap[key]!,
        //               onPressed: () {
        //                 Provider.of<ThemeModel>(context, listen: false)
        //                     .setTheme(key);
        //                 if (onThemeColorChange != null)
        //                   onThemeColorChange!(themeColorMap[key]!);
        //               },
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //   ),
        // ),
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
              Provider.of<ThemeModel>(context, listen: false)
                  .setThemeSeedColor(key);
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
