import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rui/theme_model.dart';
import 'package:rui/theme/app_theme.dart';
import 'package:rui/theme/rui_theme.dart';

class RuiApp extends StatelessWidget {
  final Widget home;
  final String title;

  Color themeColorSeed; // 主题色
  final ThemeMode themeMode = ThemeMode.system;

  RuiApp({
    super.key,
    required this.home,
    this.title = "",
    this.themeColorSeed = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    // final brightness = MediaQuery.of(context).platformBrightness;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModel()), //此是主题状态注册
      ],
      child: Consumer<ThemeModel>(
        //主题设置1：状态获取方式
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: getThemeData(themeModel.themeMode, themeModel.seedColor),
            home: home,
          );
        },
      ),
    );
  }
}
