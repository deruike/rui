import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rui/components/list/rui_left_nav_bar.dart';
import 'package:rui/components/panels/head_tools_bar.dart';
import 'package:rui/components/panels/rui_top_nav_bar.dart';
import 'package:rui/components/user/rui_login_status_panel.dart';
import 'package:rui/components/user/mini_login_status_widget.dart';

class RuiLayoutAdmin extends StatefulWidget {
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

  final Function(bool)? onLeftBarToggle;
  final Function(bool)? onRightPanelToggle;

  const RuiLayoutAdmin({
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
    this.onLeftBarToggle,
    this.onRightPanelToggle,
  });

  @override
  State<RuiLayoutAdmin> createState() => _RuiLayoutState();
}

class _RuiLayoutState extends State<RuiLayoutAdmin> {
  bool _isRightPanelOpen = false;
  bool _isLeftPanelOpen = true;

//
  // static const double TOP_HEADER_HEIGHT = 90;
  static const double TOP_HEADER_HEIGHT = 50;
  static const double BOTTOM_FOOTER_HEIGHT = 48;

  static const double LEFT_BAR_WIDTH = 200;
  static const double LEFT_BAR_CLOSED_WIDTH = 56;
  static const double LEFT_BAR_TOP_LOGO_HEIGHT = TOP_HEADER_HEIGHT;
  static const double LEFT_BAR_FOOTER_HEIGHT = 32;
  static const double LEFT_BAR_CLOSE_BTN_SIZE = 48;

  static const double RIGHT_PANEL_WIDTH = 200;
  static const double RIGHT_PANEL_CLOSED_WIDTH = 0;
  static const double RIGHT_PANEL_CLOSE_BTN_SIZE = 48;

  @override
  void initState() {
    super.initState();
  }

  bool isMobile() {
    return MediaQuery.of(context).size.width < 600;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: max(500, MediaQuery.of(context).size.width),
          height: MediaQuery.of(context).size.height,
          child:
              //  DefaultTabController(
              //   length: 3,
              //   child:
              Row(
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
                            child: Container(
                              height: MediaQuery.of(context).size.height -
                                  TOP_HEADER_HEIGHT -
                                  BOTTOM_FOOTER_HEIGHT,
                              width: MediaQuery.of(context).size.width -
                                  (_isLeftPanelOpen ? LEFT_BAR_WIDTH : 0),
                              child: widget.body,
                              //   TabBarView(
                              // children: [
                              //   Icon(Icons.directions_car),
                              //   Icon(Icons.directions_transit),
                              //   widget.body,
                              // ],
                              // ),
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
            // ),
          ),
        ),
        _buildLeftToggleButton(),
        if (widget.rightPanel != null) _buildRightToggleButton(),
      ],
    );
  }

  Widget _buildHeaderPanel() {
    return Container(
      height: TOP_HEADER_HEIGHT,
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
      child: Column(
        children: [
          Row(
            children: [
              Container(width: LEFT_BAR_CLOSE_BTN_SIZE),
              Expanded(
                child: Offstage(
                  offstage: MediaQuery.of(context).size.width < 600,
                  child: widget.headerMainPanel ?? const Text(""),
                ),
                // clipBehavior: Clip.antiAlias,
              ),
              if (widget.headerToolsPanel != null) widget.headerToolsPanel!,
              if (widget.headerUserPanel != null) widget.headerUserPanel!,
              if (widget.rightMenuButtons != null) _buildMenuAnchor(),
            ],
          ),
          // RuiTopNavBar(),
        ],
      ),
    );
  }

  Widget _buildLeftToggleButton() {
    return Positioned(
      left: _isLeftPanelOpen
          ? LEFT_BAR_WIDTH
          : (isMobile() ? 0 : LEFT_BAR_CLOSED_WIDTH),
      child: SizedBox(
        width: LEFT_BAR_CLOSE_BTN_SIZE,
        height: LEFT_BAR_CLOSE_BTN_SIZE,
        child: IconButton(
          onPressed: () {
            setState(() {
              _isLeftPanelOpen = !_isLeftPanelOpen;
              if (widget.onLeftBarToggle != null) {
                widget.onLeftBarToggle!(_isLeftPanelOpen);
              }
            });
          },
          icon: Icon(_isLeftPanelOpen
              ? Icons.format_indent_decrease_rounded
              : Icons.format_indent_increase_rounded),
        ),
      ),
    );
  }

  Widget _buildRightToggleButton() {
    return Positioned(
      left: MediaQuery.of(context).size.width -
          RIGHT_PANEL_CLOSE_BTN_SIZE -
          (_isRightPanelOpen ? RIGHT_PANEL_WIDTH : RIGHT_PANEL_CLOSED_WIDTH),
      top:
          (MediaQuery.of(context).size.height - RIGHT_PANEL_CLOSE_BTN_SIZE) / 2,
      child: SizedBox(
        width: RIGHT_PANEL_CLOSE_BTN_SIZE,
        height: RIGHT_PANEL_CLOSE_BTN_SIZE,
        child: IconButton(
          onPressed: () {
            setState(() {
              _isRightPanelOpen = !_isRightPanelOpen;
              if (widget.onRightPanelToggle != null) {
                widget.onRightPanelToggle!(_isRightPanelOpen);
              }
            });
          },
          icon: Icon(_isRightPanelOpen
              ? Icons.keyboard_double_arrow_right_rounded
              : Icons.keyboard_double_arrow_left_rounded),
        ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return SizedBox(
      width: _isLeftPanelOpen
          ? LEFT_BAR_WIDTH
          : (isMobile() ? 0 : LEFT_BAR_CLOSED_WIDTH),
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        // width: _isLeftPanelOpen ? LEFT_BAR_WIDTH : LEFT_BAR_CLOSED_WIDTH,
        child: Column(
          children: [
            _buildLeftLogoPanel(),
            SizedBox(
              // width: _isLeftPanelOpen ? LEFT_BAR_WIDTH : LEFT_BAR_CLOSED_WIDTH,
              height: MediaQuery.of(context).size.height -
                  LEFT_BAR_TOP_LOGO_HEIGHT -
                  LEFT_BAR_FOOTER_HEIGHT,
              child: widget.leftMainPanel ??
                  const Text("please set leftMainPanel"),
            ),
            if (widget.leftFooterWidget != null &&
                (_isLeftPanelOpen || !isMobile()))
              Container(child: widget.leftFooterWidget!),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftLogoPanel() {
    return SizedBox(
      width: (_isLeftPanelOpen
          ? LEFT_BAR_WIDTH
          : (isMobile() ? 0 : LEFT_BAR_CLOSED_WIDTH)),
      child: widget.leftLogoWidget!,
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: _isRightPanelOpen ? RIGHT_PANEL_WIDTH : RIGHT_PANEL_CLOSED_WIDTH,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: _isRightPanelOpen
          ? widget.rightPanel
          : SizedBox(width: RIGHT_PANEL_CLOSED_WIDTH),
    );
  }

  Widget _buildMenuAnchor() {
    return GestureDetector(
      // onTap: controller.open,
      child: MenuAnchor(
        alignmentOffset: Offset.fromDirection(3, 56),
        menuChildren: widget.rightMenuButtons as List<Widget>,
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            // focusNode: _buttonFocusNode,
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.menu),
          );
        },
      ),
    );
  }

  Widget _buildFooterPanel() {
    return Container(
      height: BOTTOM_FOOTER_HEIGHT,
      width: MediaQuery.of(context).size.width,
      // color: Colors.blue,
      child: widget.footerPanel,
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height -
            TOP_HEADER_HEIGHT -
            BOTTOM_FOOTER_HEIGHT,
        width: MediaQuery.of(context).size.width -
            (_isLeftPanelOpen ? LEFT_BAR_WIDTH : 0),
        // color: Colors.green,
        child: widget.body,
      ),
    );
  }
}
