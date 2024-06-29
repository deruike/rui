import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rui/components/layout/layout_admin/rui_layout_admin.dart';
import 'package:rui/pages/login_page.dart';
import 'package:rui/provider/session_model.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/storage/rui_storage_manager.dart';
// import 'package:rui/theme/app_theme.dart';
import 'package:rui/theme/rui_theme.dart';

// class RuiApp extends StatelessWidget {
// class RuiApp extends StatefulWidget {
class RuiApp extends MaterialApp {
  // final Widget home;
  // @override
  // final String title;

  // final String initialRoute;

  /// {@macro flutter.widgets.widgetsApp.routes}
  // final Map<String, WidgetBuilder> routes;

  final Function<bool>(String token)? onCheckUserLoginStatus;

  // final Widget body;
  final Widget? headerMainPanel;
  final Widget? headerToolsPanel;
  final Widget? headerUserPanel;

  final IconData? logo;
  final String appName;
  // final Widget? leftLogoWidget;

  // final Widget? leftMainPanel;
  // final List<Widget> leftMenuButtons;
  final Widget? leftFooterWidget;

  final Widget? rightPanel;
  final Widget? footerPanel;
  final List<MenuItemButton>? rightMenuButtons;

  final Function(bool)? onLeftBarToggle;
  final Function(bool)? onRightPanelToggle;

  final List<Widget> Function(BuildContext context) onGenLeftMenuButtons;
  // final Function(BuildContext context, String menuId) onLeftMenuItemPressed;

  @override
  State<RuiApp> createState() => _RuiAppState();

  const RuiApp({
    super.key,
    // required this.home,
    super.title = "",
    // this.themeModel,
    // this.themeColorSeed = Colors.blueGrey,
    this.onCheckUserLoginStatus,
    required super.routes,
    required super.initialRoute,
    required this.appName,
    // required this.body,
    this.headerMainPanel,
    this.headerToolsPanel,
    this.headerUserPanel,
    this.logo,
    // this.leftLogoWidget,
    // this.leftMainPanel,
    // required this.leftMenuButtons,
    required this.onGenLeftMenuButtons,
    this.leftFooterWidget,
    this.rightPanel,
    this.footerPanel,
    this.rightMenuButtons,
    this.onLeftBarToggle,
    this.onRightPanelToggle,
    // required this.onLeftMenuItemPressed,
    // this.onGenerateRoute,
  });
}

class _RuiAppState extends State<RuiApp> {
  bool isLoading = true;

  late final ThemeModel? themeModel;
  late final SessionModel? sessionModel;

  @override
  void initState() {
    super.initState();

    RuiStorageManager.load().then((ThemeModel tm) {
      themeModel = tm;

      RuiStorageManager.loadSession().then((SessionModel sm) {
        sessionModel = sm;

        setState(() {
          isLoading = false;
        });
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
              ChangeNotifierProvider(create: (context) => SessionModel())
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
                    initialRoute: widget.initialRoute ?? "/",
                    routes: widget.routes ?? {},

                    headerMainPanel: widget.headerMainPanel, // _buildHeader(),
                    headerToolsPanel:
                        widget.headerToolsPanel, //  const RuiHeadToolsBar(),
                    headerUserPanel:
                        widget.headerUserPanel, //_buildHeaderUserPanel(),
                    // leftLogoWidget: _buildLeftLogoPanel(),
                    logo: Icons.apple,
                    appName: "RUI",
                    //leftMainPanel:
                    // widget.leftMainPanel, //_buildLeftMainPanel(),
                    leftMenuButtons: widget.onGenLeftMenuButtons(context),
                    leftFooterWidget:
                        widget.leftFooterWidget, //_buildLeftFooterPanel(),
                    footerPanel: widget.footerPanel, // _buildFooter(),
                    rightMenuButtons:
                        widget.rightMenuButtons, // _buildRightMenuButtons(),
                    rightPanel: widget.rightPanel, // _buildRightPanel(),
                    onLeftBarToggle: widget.onLeftBarToggle,
                    // onLeftMenuItemPressed:
                    // widget.onLeftMenuItemPressed, // onLeftBarToggle,
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
      initialRoute: widget.initialRoute ?? "/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        if (widget.routes![settings.name!] != null) {
          builder = widget.routes![settings.name!]!;
        } else {
          builder = (BuildContext _) => const LoginPage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
