import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rui/user/mini_login_status_widget.dart';

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
  static const double LEFT_WIDTH_CLOSE = 48;
  static const double LEFT_TOPBAR_HEIGHT = 48;

  static const double RIGHT_WIDTH = 200;
  static const double RIGHT_MENU_BTN_WIDTH = 32;

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
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              setState(() {
                _isLeftNavPanelOpen = !_isLeftNavPanelOpen;
              });
            },
          ),
          Expanded(
            child: widget.header ?? const Text("Title"),
          ),
          if (widget.rightMenuButtons != null) _buildRightMenuPanel()
        ],
      ),
    );
  }

  Widget _buildLeftNavPanel() {
    return SizedBox(
      width: _isLeftNavPanelOpen ? LEFT_WIDTH : LEFT_WIDTH_CLOSE,
      height: MediaQuery.of(context).size.height,
      child: Container(
        // width: _isLeftNavPanelOpen ? LEFT_WIDTH : LEFT_WIDTH_CLOSE,
        // height: MediaQuery.of(context).size.height - TOP_HEIGHT - BOTTOM_HEIGHT,
        color: _isLeftNavPanelOpen ? Colors.brown : Colors.purple,
        // child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLeftTop(),
              widget.leftNavPanel!,
            ],
          ),
        ),
        // ),
      ),
    );
  }

  Widget _buildLeftTop() {
    return SizedBox(
      height: LEFT_TOPBAR_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.apple),
          if (_isLeftNavPanelOpen) Text("APP "),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: 200,
      color: Colors.blue,
      child: _isRightPanelOpen ? widget.rightPanel : SizedBox(width: 10),
    );
  }

  Widget _buildRightMenuPanel() {
    return Container(
      // width: RIGHT_MENU_BTN_WIDTH,
      color: Colors.blue,
      child: Row(
        children: [
          MiniLoginStatusWidget(),
          MenuAnchor(
            builder: _buildMenuAnchor,
            menuChildren: widget.rightMenuButtons ?? [],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuAnchor(_, MenuController controller, Widget? child) {
    return GestureDetector(
        onTap: controller.open,
        child: ColoredBox(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Icon(Icons.menu),
          ),
        ));
  }

  Widget _buildFooter() {
    return Container(
      height: BOTTOM_HEIGHT,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: widget.footer,
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height - TOP_HEIGHT - BOTTOM_HEIGHT,
        width: MediaQuery.of(context).size.width -
            (_isLeftNavPanelOpen ? LEFT_WIDTH : 0),
        color: Colors.green,
        child: widget.body,
      ),
    );
  }
}
