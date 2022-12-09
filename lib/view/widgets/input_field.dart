import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../helpers/theme.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.title,
      required this.hint,
      this.widget,
      this.onTap});
  final String title;
  final String hint;
  final Widget? widget;
  final Function()? onTap;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: titleStyle,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: widget.widget == null
                      ? TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            hintText: widget.hint,
                          ),
                        )
                      : TextField(
                          onTap: widget.onTap,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            hintText: widget.hint,
                          ),
                        ),
                ),
                widget.widget == null
                    ? Container()
                    : Container(child: widget.widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
