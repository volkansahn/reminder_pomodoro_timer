import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../helpers/theme.dart';

class InputField extends StatefulWidget {
  InputField(
      {super.key,
      required this.title,
      required this.hint,
      this.widget,
      this.onTap,
      this.controller,
      required this.isEditable});
  final String title;
  final String hint;
  final Widget? widget;
  final Function()? onTap;
  final bool isEditable;
  final TextEditingController? controller;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.widget == null
              ? Text(
                  widget.title,
                  style: inputTitleStyle,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: inputTitleStyle,
                    ),
                    Container(child: widget.widget),
                  ],
                ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: widget.isEditable == true
                      ? TextField(
                          style: inputTextStyle,
                          controller: widget.controller,
                          autocorrect: false,
                          maxLines: 2,
                          minLines: 1,
                        )
                      : TextField(
                          style: inputTextStyle,
                          onTap: widget.onTap,
                          readOnly: true,
                          controller: widget.controller,
                          decoration: InputDecoration.collapsed(
                            hintText: widget.hint,
                            hintStyle: inputTextStyle,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
