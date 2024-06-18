import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rui/pages/landing_page.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/storage/rui_storage_manager.dart';
// import 'package:rui/theme/app_theme.dart';
import 'package:rui/theme/rui_theme.dart';

// class RuiApp extends StatelessWidget {
class RuiApp extends StatefulWidget {
  final Widget home;
  final String title;

  Function<bool>(String token)? onCheckUserLoginStatus;

  @override
  State<RuiApp> createState() => _RuiAppState();

  RuiApp({
    super.key,
    required this.home,
    this.title = "",
    // this.themeColorSeed = Colors.blueGrey,
    this.onCheckUserLoginStatus,
  });
}

class _RuiAppState extends State<RuiApp> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    RuiStorageManager.load().then((bool ok) {
      setState(() {
        isLoading = false;
      });
    }).onError((e, st) {
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }

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
            title: widget.title,
            debugShowCheckedModeBanner: false,
            theme: getThemeData(themeModel.themeMode, themeModel.seedColor),
            // home: LandingPage(home: home),
            home: isLoading ? _buildLoading() : widget.home,
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 200,
      ),
    );
  }
}
