import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rui/components/list/left_nav_bar.dart';
import 'package:rui/components/panels/top_right_tools.dart';
import 'package:rui/components/user/login_status_panel.dart';
import 'package:rui/components/user/mini_login_status_widget.dart';

class RuiLayoutAdmin extends StatefulWidget {
  final Widget body;
  final Widget? footer;
  final Widget? header;
  final Widget? leftNavPanel;
  final Widget? rightPanel;
  final List<MenuItemButton>? rightMenuButtons;

  const RuiLayoutAdmin({
    super.key,
    required this.body,
    this.footer,
    this.header,
    this.leftNavPanel,
    this.rightMenuButtons,
    this.rightPanel,
  });

  @override
  State<RuiLayoutAdmin> createState() => _RuiLayoutState();
}

class _RuiLayoutState extends State<RuiLayoutAdmin> {
  bool _isRightPanelOpen = false;
  bool _isLeftNavPanelOpen = false;

  static const double TOP_HEIGHT = 50;
  static const double BOTTOM_HEIGHT = 32;

  static const double LEFT_WIDTH = 200;
  static const double LEFT_WIDTH_CLOSE = 56;
  static const double LEFT_TOPBAR_HEIGHT = TOP_HEIGHT;

  static const double RIGHT_PANEL_WIDTH = 200;
  static const double RIGHT_PANEL_CLOSE_WIDTH = 32;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          _buildLeftNavPanel(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Row(
                    children: [
                      _buildBody(),
                      if (widget.rightPanel != null) _buildRightPanel(),
                    ],
                  ),
                ),
                if (widget.footer != null) _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: TOP_HEIGHT,
      // color: Colors.blue,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).splashColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(5, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: _isLeftNavPanelOpen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(_isLeftNavPanelOpen
                ? Icons.format_indent_decrease_outlined
                : Icons.format_indent_increase_outlined),
            onPressed: () {
              setState(() {
                _isLeftNavPanelOpen = !_isLeftNavPanelOpen;
              });
            },
          ),
          Expanded(
            child: widget.header ?? const Text("Title"),
          ),
          TopRightTools(),
          if (widget.rightMenuButtons != null) _buildRightMenuPanel(),
          if (widget.rightPanel != null)
            IconButton(
              icon: Icon(_isRightPanelOpen
                  ? Icons.keyboard_double_arrow_right_outlined
                  : Icons.keyboard_double_arrow_left_outlined),
              onPressed: () {
                setState(() {
                  _isRightPanelOpen = !_isRightPanelOpen;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLeftNavPanel() {
    return SizedBox(
      width: _isLeftNavPanelOpen ? LEFT_WIDTH : LEFT_WIDTH_CLOSE,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          children: [
            _buildLeftTop(),
            Expanded(
              child: LeftNavBar(
                menuItems: genLeftMenuItems(),
                isOpen: _isLeftNavPanelOpen,
              ),
            ),
          ],
        ),
      ),
    );
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
      SubmenuButton(
        child: const Text("Settings"),
        leadingIcon: Icon(Icons.settings),
        menuChildren: [],
      ),
      MenuItemButton(
        child: const Text("Logout"),
        leadingIcon: Icon(Icons.logout),
        onPressed: () {
          print("Logout");
        },
      ),
    ];
  }

  Widget _buildLeftTop() {
    return SizedBox(
      height: LEFT_TOPBAR_HEIGHT,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(128),
          border: Border(
            bottom: BorderSide(color: Theme.of(context).splashColor),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(5, 3), // changes position of shadow
              // color: Colors.red,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: _isLeftNavPanelOpen
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: LEFT_WIDTH_CLOSE,
              child: Center(child: Icon(Icons.apple)),
            ),
            if (_isLeftNavPanelOpen) Text("APP "),
          ],
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: _isRightPanelOpen ? RIGHT_PANEL_WIDTH : RIGHT_PANEL_CLOSE_WIDTH,
      // color: Colors.blue,
      child: _isRightPanelOpen ? widget.rightPanel : SizedBox(width: 10),
    );
  }

  Widget _buildRightMenuPanel() {
    return Container(
      // width: RIGHT_MENU_BTN_WIDTH,
      // color: Colors.blue,
      child: Row(
        children: [
          LoginStatusPanel(
            userName: "userName",
            userImage: "https://www.ked.pub/images/avatar.jpg",
          ),
          // MenuAnchor(
          //   builder: _buildMenuAnchor,
          //   menuChildren: widget.rightMenuButtons ?? [],
          // ),
        ],
      ),
    );
  }

  Widget _buildMenuAnchor(_, MenuController controller, Widget? child) {
    return GestureDetector(
      onTap: controller.open,
      child: Icon(Icons.menu),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: BOTTOM_HEIGHT,
      width: MediaQuery.of(context).size.width,
      // color: Colors.blue,
      child: widget.footer,
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height - TOP_HEIGHT - BOTTOM_HEIGHT,
        width: MediaQuery.of(context).size.width -
            (_isLeftNavPanelOpen ? LEFT_WIDTH : 0),
        // color: Colors.green,
        child: widget.body,
      ),
    );
  }
}
