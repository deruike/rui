import 'package:flutter/material.dart';

class RuiLeftNavBar extends StatefulWidget {
  List<Widget> menuItems;
  bool isOpen = true;

  RuiLeftNavBar({super.key, required this.isOpen, required this.menuItems});

  @override
  State<RuiLeftNavBar> createState() => _RuiLeftNavBarState();

  //切换展开
}

class _RuiLeftNavBarState extends State<RuiLeftNavBar> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        widget.menuItems.length,
        (index) {
          Widget a = widget.menuItems[index];

          if (a is MenuItemButton) {
            return widget.isOpen
                ? a
                : MenuItemButton(
                    child: a.leadingIcon,
                    onPressed: a.onPressed,
                  );
          } else if (a is SubmenuButton) {
            a = !widget.isOpen
                ? SubmenuButton(
                    alignmentOffset: Offset(55, -25),
                    child: a.leadingIcon,
                    // child: a.child,
                    menuChildren: a.menuChildren,
                  )
                : Column(
                    children: [
                      MenuItemButton(
                        leadingIcon: a.leadingIcon,
                        trailingIcon: Icon(Icons.arrow_drop_up_sharp),
                        onPressed: () {
                          setState(() {});
                        },
                        child: a.child,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        color: Theme.of(context).highlightColor,
                        child: Column(
                          children: List.generate(a.menuChildren.length, (i) {
                            MenuItemButton subMenuItem = (a as SubmenuButton)
                                .menuChildren[i] as MenuItemButton;
                            return MenuItemButton(
                              leadingIcon: subMenuItem.leadingIcon,
                              onPressed: subMenuItem.onPressed,
                              child: subMenuItem.child,
                            );
                          }),
                        ),
                      ),
                    ],
                  );
          }

          return a;
        },
      ),
    );
  }
}
