import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rui/components/list/rui_left_nav_bar.dart';
import 'package:rui/components/panels/head_tools_bar.dart';
import 'package:rui/components/user/rui_login_status_panel.dart';
import 'package:rui/components/user/mini_login_status_widget.dart';

class RuiLayoutAdmin2 extends StatefulWidget {
  final Widget body;
  final Widget? headerMainPanel;
  final Widget? headerToolsPanel;
  final Widget? headerUserPanel;
  final Widget? leftLogoWidget;
  final Widget? leftMainPanel;
  final Widget? leftFooterWidget;
  final Widget? rightPanel;
  final Widget? footerPanel;
  final List<MenuItemButton>? rightMenuButtons;

  const RuiLayoutAdmin2({
    super.key,
    required this.body,
    this.headerMainPanel,
    this.headerToolsPanel,
    this.headerUserPanel,
    this.leftLogoWidget,
    this.leftMainPanel,
    this.leftFooterWidget,
    this.rightPanel,
    this.footerPanel,
    this.rightMenuButtons,
  });

  @override
  State<RuiLayoutAdmin2> createState() => _RuiLayoutState();
}

class _RuiLayoutState extends State<RuiLayoutAdmin2> {
  bool _isRightPanelOpen = false;
  bool _isLeftPanelOpen = false;

  static const double TOP_HEIGHT = 48;
  static const double BOTTOM_HEIGHT = 48;

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
          _buildLeftPanel(),
          Expanded(
            child: Column(
              children: [
                _buildHeaderPanel(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        // child: Text("ttt"),
                        child: Container(
                          height: MediaQuery.of(context).size.height -
                              TOP_HEIGHT -
                              BOTTOM_HEIGHT,
                          width: MediaQuery.of(context).size.width -
                              (_isLeftPanelOpen ? LEFT_WIDTH : 0),
                          // color: Colors.green,
                          child: widget.body,
                        ),
                      ),
                      if (widget.rightPanel != null) _buildRightPanel(),
                    ],
                  ),
                ),
                if (widget.footerPanel != null) _buildFooterPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderPanel() {
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
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: _isLeftPanelOpen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(_isLeftPanelOpen
                ? Icons.format_indent_decrease_outlined
                : Icons.format_indent_increase_outlined),
            onPressed: () {
              setState(() {
                _isLeftPanelOpen = !_isLeftPanelOpen;
              });
            },
          ),
          Expanded(
            child: widget.headerMainPanel ?? const Text("Title"),
          ),
          if (widget.headerToolsPanel != null) widget.headerToolsPanel!,
          if (widget.headerUserPanel != null) widget.headerUserPanel!,
          // if (widget.rightMenuButtons != null) widget.rightMenuButtons!,
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

  Widget _buildLeftPanel() {
    return SizedBox(
      width: _isLeftPanelOpen ? LEFT_WIDTH : LEFT_WIDTH_CLOSE,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          children: [
            _buildLeftTop(),
            Expanded(
              child: widget.leftMainPanel ?? const Text("Left Nav Panel"),
            ),
            if (widget.leftFooterWidget != null)
              Container(
                child: widget.leftFooterWidget!,
              ),
          ],
        ),
      ),
    );
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
          mainAxisAlignment: _isLeftPanelOpen
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: LEFT_WIDTH_CLOSE,
              child: Center(child: Icon(Icons.apple)),
            ),
            if (_isLeftPanelOpen) Text("APP "),
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

  Widget _buildMenuAnchor(_, MenuController controller, Widget? child) {
    return GestureDetector(
      onTap: controller.open,
      child: Icon(Icons.menu),
    );
  }

  Widget _buildFooterPanel() {
    return Container(
      height: BOTTOM_HEIGHT,
      width: MediaQuery.of(context).size.width,
      // color: Colors.blue,
      child: widget.footerPanel,
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height - TOP_HEIGHT - BOTTOM_HEIGHT,
        width: MediaQuery.of(context).size.width -
            (_isLeftPanelOpen ? LEFT_WIDTH : 0),
        // color: Colors.green,
        child: widget.body,
      ),
    );
  }
}
