import 'package:flutter/material.dart';
import 'package:rui/user/mini_login_status_widget.dart';

class RuiLayout extends StatefulWidget {
  final Widget body;
  final Widget? footer;
  final Widget? header;
  final Widget? leftNavPanel;
  final Widget? rightPanel;
  final List<MenuItemButton>? rightMenuButtons;

  const RuiLayout({
    super.key,
    required this.body,
    this.footer,
    this.header,
    this.leftNavPanel,
    this.rightMenuButtons,
    this.rightPanel,
  });

  @override
  State<RuiLayout> createState() => _RuiLayoutState();
}

class _RuiLayoutState extends State<RuiLayout> {
  bool _isRightPanelOpen = false;
  bool _isLeftNavPanelOpen = false;

  static const double TOP_HEIGHT = 50;
  static const double BOTTOM_HEIGHT = 50;
  static const double LEFT_WIDTH = 200;
  static const double RIGHT_WIDTH = 200;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Row(
              children: [
                if (widget.leftNavPanel != null) _buildLeftNavPanel(),
                Expanded(
                  child: Column(
                    children: [
                      _buildBody(),
                    ],
                  ),
                ),
                if (widget.rightPanel != null) _buildRightPanel(),
              ],
            ),
          ),
          if (widget.footer != null) _buildFooter(),
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
    return Container(
      width: LEFT_WIDTH,
      height: MediaQuery.of(context).size.height - TOP_HEIGHT - BOTTOM_HEIGHT,
      color: Colors.blue,
      child: _isLeftNavPanelOpen ? widget.leftNavPanel : SizedBox(width: 10),
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
      width: RIGHT_WIDTH,
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
          color: Colors.blue,
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
