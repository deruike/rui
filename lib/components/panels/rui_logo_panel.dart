import 'package:flutter/material.dart';

class RuiLogoPanel extends StatefulWidget {
  final bool isOpen;
  final double width;
  final double widthClose;
  final double height;
  final Icon icon;
  final String? title;
  final String? subTitle;
  final String? imageUrl;
  final Function? onTap;
  const RuiLogoPanel({
    super.key,
    required this.isOpen,
    required this.width,
    required this.height,
    required this.icon,
    this.title,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.widthClose,
  });

  @override
  State<RuiLogoPanel> createState() => _RuiLogoPanelState();
}

class _RuiLogoPanelState extends State<RuiLogoPanel> {
  // bool _isLeftPanelOpen = widget.isOpen;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
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
          mainAxisAlignment: widget.isOpen
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: widget.widthClose,
              child: Center(child: widget.icon),
            ),
            if (widget.isOpen) Text(widget.title ?? ""),
          ],
        ),
      ),
    );
  }
}
