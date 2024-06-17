import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rui/components/list/rui_left_nav_bar.dart';
// import 'package:rui/rui_material_app.dart';
import 'package:rui/components/panels/head_tools_bar.dart';
import 'package:rui/components/panels/rui_logo_panel.dart';
import 'package:rui/components/user/rui_login_status_panel.dart';

import 'package:rui/index.dart';

import 'package:rui/rui_app.dart';

void main() {
  // runApp(const MyApp());
  runApp(RuiApp(
    title: "RUI APP",
    home: MyHomePage(
      title: 'Flutter Demo Home Page',
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  TextStyle textStyle =
      const TextStyle(color: Color(0xFF333333), fontSize: 15.0);

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
  bool _isLeftPanelOpen = true;
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
      body: RuiLayoutAdmin(
        headerMainPanel: _buildHeader(),
        headerToolsPanel: const RuiHeadToolsBar(),
        headerUserPanel: _buildHeaderUserPanel(),
        leftLogoWidget: _buildLeftLogoPanel(),
        leftMainPanel: _buildLeftMainPanel(),
        leftFooterWidget: _buildLeftFooterPanel(),
        body: _buildBody(),
        footerPanel: _buildFooter(),
        // rightMenuButtons: _buildRightMenuButtons(),
        rightPanel: _buildRightPanel(),

        onLeftBarToggle: onLeftBarToggle,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildHeader() {
    return Container(
      // color: Colors.blue,
      child: Text("Demo of Rui"),
    );
  }

  Widget _buildHeaderUserPanel() {
    return Container(
      child: Row(
        children: [
          RuiLoginStatusPanel(
            userName: "userName",
            userImage: "https://www.ked.pub/images/avatar.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      // color: Colors.red,
      child: Text(
        '$_counter',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      // color: Colors.green,
      child: Text("Footer"),
    );
  }

  Widget _buildLeftLogoPanel() {
    return RuiLogoPanel(
      isOpen: true,
      width: 200,
      height: 56,
      icon: Icon(Icons.apple),
      title: _isLeftPanelOpen ? 'Listenor' : null,
      widthClose: 56,
    );
  }

  Widget _buildLeftMainPanel() {
    // return Text("data");
    return RuiLeftNavBar(
        isOpen: _isLeftPanelOpen, menuItems: genLeftMenuItems());
  }

  Widget _buildLeftFooterPanel() {
    return Text("Footer");
  }

  void onLeftBarToggle(bool isOpen) {
    setState(() {
      _isLeftPanelOpen = isOpen;
    });
  }

  List<Widget> genLeftMenuItems() {
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

  List<MenuItemButton> _buildRightMenuButtons() {
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

  Widget _buildRightPanel() {
    return Container(
      // color: Colors.purple,
      child: Text("Right Panel"),
    );
  }
}
