import 'package:flutter/material.dart';

class RuiInput extends StatefulWidget {
  String labelText;

  String hintText;

  double width = 200;

  Function(String)? onSubmit;
  Function(String)? onChange;
  Function()? onBlur;
  Function()? onFocus;

  RuiInput({
    super.key,
    required this.width,
    required this.labelText,
    required this.hintText,
    this.onSubmit,
    this.onChange,
    this.onBlur,
    this.onFocus,
  });

  @override
  State<RuiInput> createState() => _RuiInputState();
}

class _RuiInputState extends State<RuiInput> {
  final myController = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus && widget.onFocus != null) widget.onFocus!();
      if (!myFocusNode.hasFocus && widget.onBlur != null) widget.onBlur!();
    });

    myController.addListener(() {
      if (widget.onChange != null) widget.onChange!(myController.text);
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        focusNode: myFocusNode,
        controller: myController,
        autofocus: true,
        onSubmitted: (value) =>
            {if (widget.onSubmit != null) widget.onSubmit!(value)},
      ),
    );
  }
}
