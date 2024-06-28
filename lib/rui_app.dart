import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rui/components/layout/layout_admin/rui_layout_admin.dart';
import 'package:rui/pages/landing_page.dart';
import 'package:rui/pages/login_page.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/storage/rui_storage_manager.dart';
// import 'package:rui/theme/app_theme.dart';
import 'package:rui/theme/rui_theme.dart';

// class RuiApp extends StatelessWidget {
// class RuiApp extends StatefulWidget {
class RuiApp extends MaterialApp {
  // final Widget home;
  final String title;

  final String initialRoute;

  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder> routes;

  Function<bool>(String token)? onCheckUserLoginStatus;

  // final Widget body;
  final Widget? headerMainPanel;
  final Widget? headerToolsPanel;
  final Widget? headerUserPanel;

  final IconData? logo;
  final String appName;
  // final Widget? leftLogoWidget;

  final Widget? leftMainPanel;
  final Widget? leftFooterWidget;

  final Widget? rightPanel;
  final Widget? footerPanel;
  final List<MenuItemButton>? rightMenuButtons;

  final Function(bool)? onLeftBarToggle;
  final Function(bool)? onRightPanelToggle;

  @override
  State<RuiApp> createState() => _RuiAppState();

  RuiApp({
    super.key,
    // required this.home,
    this.title = "",
    // this.themeModel,
    // this.themeColorSeed = Colors.blueGrey,
    this.onCheckUserLoginStatus,
    required this.routes,
    required this.initialRoute,
    required this.appName,
    // required this.body,
    this.headerMainPanel,
    this.headerToolsPanel,
    this.headerUserPanel,
    this.logo,
    // this.leftLogoWidget,
    this.leftMainPanel,
    this.leftFooterWidget,
    this.rightPanel,
    this.footerPanel,
    this.rightMenuButtons,
    this.onLeftBarToggle,
    this.onRightPanelToggle,
    // this.onGenerateRoute,
  });
}

class _RuiAppState extends State<RuiApp> {
  bool isLoading = true;

  late final ThemeModel? themeModel;

  @override
  void initState() {
    super.initState();

    RuiStorageManager.load().then((ThemeModel _themeModel) {
      themeModel = _themeModel;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final brightness = MediaQuery.of(context).platformBrightness;

    return isLoading
        ? _buildLoading()
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => ThemeModel()
                    ..setThemeModel(themeModel ?? ThemeModel())), //此是主题状态注册
            ],
            child: Consumer<ThemeModel>(
              //主题设置1：状态获取方式
              builder: (context, themeModel, child) {
                return MaterialApp(
                  title: widget.title,
                  debugShowCheckedModeBanner: false,
                  theme: getThemeData(
                      themeModel.themeMode, themeModel.themeSeedColor),
                  // home: LandingPage(home: home),
                  // home: isLoading ? _buildLoading() : widget.home,
                  home: RuiLayoutAdmin(
                    initialRoute: widget.initialRoute,
                    routes: widget.routes,

                    headerMainPanel: widget.headerMainPanel, // _buildHeader(),
                    headerToolsPanel:
                        widget.headerToolsPanel, //  const RuiHeadToolsBar(),
                    headerUserPanel:
                        widget.headerUserPanel, //_buildHeaderUserPanel(),
                    // leftLogoWidget: _buildLeftLogoPanel(),
                    logo: Icons.apple,
                    appName: "RUI",
                    leftMainPanel:
                        widget.leftMainPanel, //_buildLeftMainPanel(),
                    leftFooterWidget:
                        widget.leftFooterWidget, //_buildLeftFooterPanel(),
                    body: //widget.body,
                        _buildBody(),
                    footerPanel: widget.footerPanel, // _buildFooter(),
                    rightMenuButtons:
                        widget.rightMenuButtons, // _buildRightMenuButtons(),
                    rightPanel: widget.rightPanel, // _buildRightPanel(),
                    onLeftBarToggle: widget.onLeftBarToggle, // onLeftBarToggle,
                  ),
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

  Widget _buildBody() {
    return Navigator(
      initialRoute: '/',
      // pages: [
      //   MaterialPage(child: LoginPage()),
      // ],
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        if (widget.routes[settings.name!] != null) {
          builder = widget.routes[settings.name!]!;
        } else {
          builder = (BuildContext _) => LoginPage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
