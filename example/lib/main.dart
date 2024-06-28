import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rui/components/layout/layout_admin/rui_layout_admin.dart';
import 'package:rui/components/list/rui_left_nav_bar.dart';
// import 'package:rui/rui_material_app.dart';
import 'package:rui/components/panels/head_tools_bar.dart';
import 'package:rui/components/panels/rui_logo_panel.dart';
import 'package:rui/components/user/rui_login_status_panel.dart';
import 'package:rui/pages/login_page.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/rui_route.dart';
import 'package:rui/storage/rui_storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:rui/index.dart';

import 'package:rui/rui_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  // runApp();
}

class MyApp extends StatelessWidget {
  bool _isLeftPanelOpen = true;

  @override
  Widget build(BuildContext context) {
    return RuiApp(
      title: "RUI APP",
      // themeModel: themeModel,
      // 定义初始路由
      initialRoute: '/',
      routes: {
        // 定义路由映射
        '/home': (context) => MyHomePage(
              title: 'Flutter Demo Home Page',
            ),
        '/login': (context) => LoginPage(),
      },
      headerMainPanel: _buildHeader(context),
      headerToolsPanel: const RuiHeadToolsBar(),
      headerUserPanel: _buildHeaderUserPanel(context),
      // leftLogoWidget: _buildLeftLogoPanel(),
      logo: Icons.apple,
      appName: "RUI",
      leftMainPanel: _buildLeftMainPanel(context),
      leftFooterWidget: _buildLeftFooterPanel(context),
      // body: _buildBody(context),
      footerPanel: _buildFooter(context),
      rightMenuButtons: _buildRightMenuButtons(context),
      rightPanel: _buildRightPanel(context),
      onLeftBarToggle: onLeftBarToggle,
      // home: MyHomePage(
      //   title: 'Flutter Demo Home Page',
      // ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Text("Demo of Rui"),
    );
  }

  Widget _buildHeaderUserPanel(BuildContext context) {
    return Container(
      child: Row(
        children: [
          RuiLoginStatusPanel(
            userName: "张三",
            userPhone: "18000000000",
            userImage:
                "https://th.bing.com/th?id=OSK.f7f4e9af4e9ca9ea2585e5df12ff1c5f&w=80&h=80&c=7&o=6&dpr=2&pid=SANGAM",
            userEmail: "test@qwe.com",
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Text("ddd"),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: Text("Footer"),
    );
  }

  Widget _buildLeftMainPanel(BuildContext context) {
    // return Text("data");
    return RuiLeftNavBar(
        isOpen: _isLeftPanelOpen, menuItems: genLeftMenuItems(context));
  }

  Widget _buildLeftFooterPanel(BuildContext context) {
    return _isLeftPanelOpen ? Text("Footer") : Icon(Icons.abc);
  }

  void onLeftBarToggle(bool isOpen) {
    // setState(() {
    //   _isLeftPanelOpen = isOpen;
    // });
  }

  List<Widget> genLeftMenuItems(BuildContext context) {
    return [
      MenuItemButton(
        child: const Text("Home"),
        leadingIcon: Icon(Icons.home),
        onPressed: () {
          print("Home");
          print(MediaQuery.of(context).size.height);
        },
      ),
      SubmenuButton(
        child: const Text("About"),
        leadingIcon: Icon(Icons.info),
        menuChildren: [
          MenuItemButton(
            child: const Text("About Us"),
            leadingIcon: Icon(Icons.person),
            onPressed: () {
              print("About Us");
            },
          ),
          MenuItemButton(
            child: const Text("Contact Us"),
            leadingIcon: Icon(Icons.email),
            onPressed: () {
              print("Contact Us");
            },
          ),
        ],
      ),
      const SubmenuButton(
        leadingIcon: Icon(Icons.settings),
        menuChildren: [],
        child: Text("Settings"),
      ),
      MenuItemButton(
        leadingIcon: const Icon(Icons.logout),
        onPressed: () {
          print("Logout");
        },
        child: const Text("Logout"),
      ),
    ];
  }

  List<MenuItemButton> _buildRightMenuButtons(BuildContext context) {
    return [
      MenuItemButton(
        child: Text('打开'),
        shortcut: SingleActivator(LogicalKeyboardKey.keyO, control: true),
        onPressed: () {
          print("======打开==========");
        },
      ),
      MenuItemButton(
        child: Text('print'),
        shortcut: SingleActivator(LogicalKeyboardKey.keyE, meta: true),
        onPressed: () {
          print("======print==========");
        },
      ),
      MenuItemButton(
        child: Text('Exit'),
        onPressed: () {
          print("======exit==========");
        },
      ),
    ];
  }

  Widget _buildRightPanel(BuildContext context) {
    return Container(
      // color: Colors.purple,
      child: Text("Right Panel"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  TextStyle textStyle =
      const TextStyle(color: Color(0xFF333333), fontSize: 100.0);

  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(20), // 自定义 AppBar 高度
      //   child: AppBar(
      //     // TRY THIS: Try changing the color here to a specific color (to
      //     // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //     // change color while the other colors stay the same.
      //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //     // Here we take the value from the MyHomePage object that was created by
      //     // the App.build method, and use it to set our appbar title.
      //     title: Text(widget.title),
      //   ),
      // ),
      body: Column(
        children: [
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushNamed(context, "/login");
              Navigator.push(context, CustomPageRoute(child: LoginPage()));
            },
            child: Text("Goto login"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
