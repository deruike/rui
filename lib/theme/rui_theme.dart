import 'package:flutter/material.dart';

Map<String, Color> themeColorMap = {
  'red': Colors.redAccent,
  'orange': Colors.orange,
  'yellow': Colors.yellow,
  'green': Colors.green,
  'cyan': Colors.cyan,
  'blue': Colors.blue,
  'purple': Colors.purple,
  'indigo': Colors.indigo,
  'pink': Colors.pink,
  'teal': Colors.teal,
};

ThemeData _genRuiTheme({
  Brightness brightness = Brightness.dark,
  Color seedColor = Colors.blue,
  String font = "Roboto",
}) {
  return ThemeData(
    // primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
    useMaterial3: true,
    fontFamily: font,
  );
}

ThemeData getThemeData(
  ThemeMode themeMode,
  String themeColor,
) {
  if (themeMode == ThemeMode.system) {
    return _genRuiTheme(
        brightness: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .platformBrightness ==
                Brightness.dark
            ? Brightness.dark
            : Brightness.light,
        seedColor: themeColorMap[themeColor] ?? Colors.blueGrey);
  }
  return _genRuiTheme(
      brightness:
          themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      seedColor: themeColorMap[themeColor] ?? Colors.blueGrey);
}
